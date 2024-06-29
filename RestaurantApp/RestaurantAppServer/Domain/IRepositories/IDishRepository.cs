using Domain.Entities;

namespace Domain.Repositories;

public interface IDishRepository
{
    Task<List<Dish>> GetAllDishes();
}