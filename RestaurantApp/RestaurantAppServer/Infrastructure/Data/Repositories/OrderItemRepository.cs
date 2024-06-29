using Domain.Entities;
using Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data.Repositories;

public class OrderItemRepository: IOrderItemRepository
{
    private readonly AppDbContext appDbContext;

    public OrderItemRepository(AppDbContext appDbContext)
    {
        this.appDbContext = appDbContext;
    }
    
    public async Task AddOrderItem(OrderItem orderItem)
    {
        appDbContext.Dishes.Attach(orderItem.Dish);
        await appDbContext.OrderItems.AddAsync(orderItem);
        await appDbContext.SaveChangesAsync();
    }

    public async Task<List<OrderItem>> GetOrderItemsByUserId(int userId)
    {
        return await appDbContext.OrderItems
            .Include(orderItem => orderItem.Dish)
            .Where(orderItem => orderItem.UserId == userId)
            .ToListAsync();
    }

    public async Task ClearCartForUser(int userId)
    {
        var orderItems = await appDbContext.OrderItems
            .Where(orderItem => orderItem.UserId == userId)
            .ToListAsync();

        appDbContext.OrderItems.RemoveRange(orderItems);
        await appDbContext.SaveChangesAsync();    
    }
    
    public async Task<OrderItem> FindByUserIdAndDishId(int userId, int dishId)
    {
        return await appDbContext.OrderItems.FirstOrDefaultAsync(oi => oi.UserId == userId && oi.DishId == dishId);
    }
    
    public async Task UpdateOrderItem(OrderItem orderItem)
    {
        appDbContext.OrderItems.Update(orderItem);
        await appDbContext.SaveChangesAsync();
    }
    
    public async Task DeleteOrderItem(OrderItem orderItem)
    {
        appDbContext.OrderItems.Remove(orderItem);
        await appDbContext.SaveChangesAsync();
    }
}