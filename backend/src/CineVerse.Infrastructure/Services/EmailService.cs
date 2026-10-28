using CineVerse.Application.Common.Interfaces;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using MimeKit;

namespace CineVerse.Infrastructure.Services;

/// <summary>
/// Надсилання транзакційних листів через SMTP (MailKit) — п.1.5.1 ТЗ.
/// Якщо Smtp:Host не налаштовано (типово для локальної розробки) — лист не відправляється,
/// а лише логується, щоб розробник міг узяти токен/посилання з логів без реального email-акаунту.
///
/// Раніше тут був SendGrid, але для студентського проєкту без бізнес-акаунту SendGrid зараз
/// вимагає верифікацію домену ще до першого листа — тобто "робочим" воно фактично ніколи не
/// ставало. SMTP через звичайний Gmail + App Password реально запускається за кілька хвилин
/// (див. .env.example) і саме так перевірявся цей клас.
/// </summary>
public class EmailService : IEmailService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<EmailService> _logger;

    public EmailService(IConfiguration configuration, ILogger<EmailService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task SendEmailConfirmationAsync(string toEmail, string confirmationToken, CancellationToken cancellationToken = default)
    {
        var frontendUrl = _configuration["Frontend:BaseUrl"] ?? "http://localhost:5173";
        var confirmationLink = $"{frontendUrl}/confirm-email?token={confirmationToken}";

        var subject = "CineVerse — підтвердження реєстрації";
        var htmlContent = $"""
            <h2>Ласкаво просимо до CineVerse!</h2>
            <p>Щоб завершити реєстрацію, підтвердіть свою електронну адресу:</p>
            <p><a href="{confirmationLink}">Підтвердити email</a></p>
            <p>Якщо ви не реєструвались у CineVerse — просто проігноруйте цей лист.</p>
            """;

        await SendAsync(toEmail, subject, htmlContent, cancellationToken);
    }

    public async Task SendTicketsAsync(string toEmail, IEnumerable<Guid> ticketIds, CancellationToken cancellationToken = default)
    {
        // TODO (Етап 6 — Оплата та квитки): вкладення PDF з QR-кодами (QRCoder) генеруються
        // у відповідному хендлері обробки Webhook і передаються сюди як attachments.
        var subject = "CineVerse — ваші електронні квитки";
        var htmlContent = $"<p>Ваші квитки ({ticketIds.Count()} шт.) додано до особистого кабінету.</p>";

        await SendAsync(toEmail, subject, htmlContent, cancellationToken);
    }

    public async Task SendPasswordResetAsync(string toEmail, string resetToken, CancellationToken cancellationToken = default)
    {
        var frontendUrl = _configuration["Frontend:BaseUrl"] ?? "http://localhost:5173";
        var resetLink = $"{frontendUrl}/reset-password?token={resetToken}";

        var subject = "CineVerse — відновлення пароля";
        var htmlContent = $"""
            <h2>Відновлення пароля</h2>
            <p>Ви (або хтось від вашого імені) запросили скидання пароля для акаунту CineVerse.</p>
            <p><a href="{resetLink}">Встановити новий пароль</a></p>
            <p>Посилання дійсне 30 хвилин. Якщо ви не робили цей запит — просто проігноруйте лист,
            пароль залишиться незмінним.</p>
            """;

        await SendAsync(toEmail, subject, htmlContent, cancellationToken);
    }

    private async Task SendAsync(string toEmail, string subject, string htmlContent, CancellationToken cancellationToken)
    {
        var host = _configuration["Smtp:Host"];
        var fromEmail = _configuration["Smtp:FromEmail"] ?? "noreply@cineverse.local";
        var fromName = _configuration["Smtp:FromName"] ?? "CineVerse";

        if (string.IsNullOrWhiteSpace(host))
        {
            _logger.LogInformation(
                "[DEV MODE] Smtp:Host не налаштовано. Лист до {ToEmail} не надіслано, вміст:\nТема: {Subject}\n{Content}",
                toEmail, subject, htmlContent);
            return;
        }

        var port = int.TryParse(_configuration["Smtp:Port"], out var parsedPort) ? parsedPort : 587;
        var username = _configuration["Smtp:Username"];
        var password = _configuration["Smtp:Password"];

        var message = new MimeMessage();
        message.From.Add(new MailboxAddress(fromName, fromEmail));
        message.To.Add(MailboxAddress.Parse(toEmail));
        message.Subject = subject;
        message.Body = new BodyBuilder { HtmlBody = htmlContent }.ToMessageBody();

        try
        {
            using var client = new SmtpClient();
            // StartTlsWhenAvailable підходить і для Gmail (587), і для більшості інших провайдерів
            // без потреби вручну обирати SslOnConnect (465) чи None (25).
            await client.ConnectAsync(host, port, SecureSocketOptions.StartTlsWhenAvailable, cancellationToken);

            if (!string.IsNullOrWhiteSpace(username))
            {
                await client.AuthenticateAsync(username, password, cancellationToken);
            }

            await client.SendAsync(message, cancellationToken);
            await client.DisconnectAsync(true, cancellationToken);
        }
        catch (Exception ex)
        {
            // Лист — не критична для основного флоу операція (бронювання/оплата вже збережені
            // до цього виклику, див. TicketIssuanceService.SendTicketEmailSafeAsync) — тому тут
            // лише логуємо, а не кидаємо виняток далі.
            _logger.LogWarning(ex, "Не вдалося надіслати лист до {ToEmail} через SMTP {Host}:{Port}", toEmail, host, port);
        }
    }
}
