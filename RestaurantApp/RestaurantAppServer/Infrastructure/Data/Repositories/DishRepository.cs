using Domain.Entities;
using Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data.Repositories;

public class DishRepository: IDishRepository
{
    private readonly AppDbContext appDbContext;

    public DishRepository(AppDbContext appDbContext)
    {
        this.appDbContext = appDbContext;
    }
    
    public async Task<List<Dish>> GetAllDishes()
    {
        return await appDbContext.Dishes.ToListAsync();
    }
}