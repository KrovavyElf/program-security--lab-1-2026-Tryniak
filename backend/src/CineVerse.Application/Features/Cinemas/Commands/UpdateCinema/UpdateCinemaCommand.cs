using MediatR;

namespace CineVerse.Application.Features.Cinemas.Commands.UpdateCinema;

/// <summary>Редагування картки кінотеатру (кабінет адміністратора, п.2.5 ТЗ: "CRUD-операції
/// для кінотеатрів, залів"). Правки лише "паспортних" полів локації — Name/Address/City/Phone;
/// список залів (Halls) до цієї команди не входить і редагується окремо через
/// CreateHall/UpdateHall, так само як розсадку залу не можна змінити через UpdateHall.</summary>
public record UpdateCinemaCommand(
    Guid CinemaId,
    string Name,
    string Address,
    string City,
    string Phone
) : IRequest;
