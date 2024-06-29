using Domain.Entities;
using Domain.Repositories;

namespace Infrastructure.Data.Repositories;

public class ReservationRepository: IReservationRepository
{
    private readonly AppDbContext appDbContext;

    public ReservationRepository(AppDbContext appDbContext)
    {
        this.appDbContext = appDbContext;
    }
    
    public async Task AddReservation(Reservation newReservation)
    {
        await appDbContext.Reservations.AddAsync(newReservation);
        await appDbContext.SaveChangesAsync();
    }
}