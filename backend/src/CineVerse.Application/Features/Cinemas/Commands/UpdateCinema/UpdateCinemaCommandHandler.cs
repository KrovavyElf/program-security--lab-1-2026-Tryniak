using CineVerse.Application.Common.Exceptions;
using CineVerse.Application.Common.Interfaces;
using CineVerse.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace CineVerse.Application.Features.Cinemas.Commands.UpdateCinema;

public class UpdateCinemaCommandHandler : IRequestHandler<UpdateCinemaCommand>
{
    private readonly IApplicationDbContext _context;

    public UpdateCinemaCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task Handle(UpdateCinemaCommand request, CancellationToken cancellationToken)
    {
        var cinema = await _context.Cinemas.FirstOrDefaultAsync(c => c.Id == request.CinemaId, cancellationToken)
            ?? throw new NotFoundException(nameof(Cinema), request.CinemaId);

        cinema.Name = request.Name;
        cinema.Address = request.Address;
        cinema.City = request.City;
        cinema.Phone = request.Phone;

        await _context.SaveChangesAsync(cancellationToken);
    }
}
