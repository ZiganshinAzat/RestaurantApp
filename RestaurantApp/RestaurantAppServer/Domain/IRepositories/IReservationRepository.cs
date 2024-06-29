using Domain.Entities;

namespace Domain.Repositories;

public interface IReservationRepository
{
    public Task AddReservation(Reservation newReservation);
}