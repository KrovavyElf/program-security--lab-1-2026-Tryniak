namespace CineVerse.Application.Common;

/// <summary>
/// Часовий пояс мережі кінотеатрів (Україна, п.1 ТЗ) — спільний для всіх місць, де "календарний
/// день" рахується за місцевим часом глядача/каси, а не в UTC: фільтр розкладу сеансів
/// (GetSessionsQueryHandler) і групування виручки по днях (GetRevenueByDayQueryHandler).
/// Якщо колись з'явиться мультирегіональна мережа — це стане властивістю Cinema, а не
/// константою тут.
/// </summary>
public static class CinemaTimeZone
{
    public static readonly TimeZoneInfo Value = Resolve();

    private static TimeZoneInfo Resolve()
    {
        try
        {
            return TimeZoneInfo.FindSystemTimeZoneById("Europe/Kyiv");
        }
        catch (TimeZoneNotFoundException)
        {
            // Захист на випадок, якщо базовий Docker-образ не містить tzdata: краще працювати
            // в UTC (стара поведінка), ніж впасти повністю. Офіційні образи mcr.microsoft.com/dotnet
            // включають tzdata "з коробки", тому на практиці цей catch — лише страховка.
            return TimeZoneInfo.Utc;
        }
    }
}
