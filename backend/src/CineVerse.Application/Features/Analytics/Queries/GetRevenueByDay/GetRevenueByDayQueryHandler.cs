using CineVerse.Application.Common;
using CineVerse.Application.Common.Interfaces;
using CineVerse.Domain.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace CineVerse.Application.Features.Analytics.Queries.GetRevenueByDay;

public class GetRevenueByDayQueryHandler : IRequestHandler<GetRevenueByDayQuery, IReadOnlyList<RevenueByDayDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IDateTime _dateTime;

    public GetRevenueByDayQueryHandler(IApplicationDbContext context, IDateTime dateTime)
    {
        _context = context;
        _dateTime = dateTime;
    }

    public async Task<IReadOnlyList<RevenueByDayDto>> Handle(GetRevenueByDayQuery request, CancellationToken cancellationToken)
    {
        var days = Math.Clamp(request.Days, 1, 90);
        var sinceUtc = _dateTime.UtcNow.AddDays(-days);

        // ВИПРАВЛЕННЯ: виручку тепер прив'язуємо до дня СЕАНСУ (Session.StartTime), а не дня
        // створення бронювання (Booking.CreatedAt), як було раніше. Квиток, куплений завчасно
        // на сеанс наступного тижня, "спотворював" би виручку дня покупки — а для дашборду
        // "скільки заробив кожен день показів" важливий саме день, коли клієнт фактично прийшов
        // у кіно, а не день, коли він натиснув "Оплатити".
        //
        // Групуємо В ПАМ'ЯТІ (після ToListAsync), а не безпосередньо в SQL: конвертацію
        // Session.StartTime (UTC) у календарний день ЗА ЧАСОВИМ ПОЯСОМ КІНОТЕАТРУ
        // (TimeZoneInfo.ConvertTime, той самий CinemaTimeZone, що й у GetSessionsQueryHandler)
        // неможливо надійно транслювати в SQL через Npgsql EF-провайдер. Для дашборду з вікном
        // максимум 90 днів матеріалізація рядків перед групуванням не є проблемою продуктивності.
        var raw = await _context.Bookings
            .Where(b => b.Status == BookingStatus.CONFIRMED && b.Session.StartTime >= sinceUtc)
            .Select(b => new { b.TotalPrice, SessionStartTime = b.Session.StartTime })
            .ToListAsync(cancellationToken);

        return raw
            .GroupBy(b => DateOnly.FromDateTime(TimeZoneInfo.ConvertTime(b.SessionStartTime, CinemaTimeZone.Value).DateTime))
            .Select(g => new RevenueByDayDto(g.Key, g.Sum(x => x.TotalPrice), g.Count()))
            .OrderBy(r => r.Date)
            .ToList();
    }
}
