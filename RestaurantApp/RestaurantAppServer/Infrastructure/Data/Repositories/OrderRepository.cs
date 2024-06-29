using Domain.Entities;
using Domain.Enums;
using Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data.Repositories;

public class OrderRepository: IOrderRepository
{
    private readonly AppDbContext appDbContext;

    public OrderRepository(AppDbContext appDbContext)
    {
        this.appDbContext = appDbContext;
    }
    
    public async Task Add(Order order)
    {
        foreach (var orderItem in order.OrderItems)
        {
            appDbContext.Entry(orderItem).State = EntityState.Unchanged;
        }
        appDbContext.Orders.Add(order);
        await appDbContext.SaveChangesAsync();
    }
    
    public async Task<List<Order>> GetOrdersExcludingStatuses(List<OrderStatus> excludedStatuses)
    {
        return await appDbContext.Orders
            .Where(o => !excludedStatuses.Contains(o.Status))
            .ToListAsync();
    }
    
    public async Task<Order> FindByIdAsync(int orderId)
    {
        return await appDbContext.Orders.FindAsync(orderId);
    }

    public async Task UpdateAsync(Order order)
    {
        appDbContext.Orders.Update(order);
        await appDbContext.SaveChangesAsync();
    }

    public async Task<List<Order>> GetOrdersByUserId(int userId)
    {
        return await appDbContext.Orders
            .Where(o => o.UserId == userId)
            .ToListAsync();
    }
}