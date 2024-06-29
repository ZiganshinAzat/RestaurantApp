using Domain.Entities;
using Domain.Enums;

namespace Domain.Repositories;

public interface IOrderRepository
{
    public Task Add(Order order);
    public Task<List<Order>> GetOrdersExcludingStatuses(List<OrderStatus> excludedStatuses);
    public Task UpdateAsync(Order order);
    public Task<Order> FindByIdAsync(int orderId);
    public Task<List<Order>> GetOrdersByUserId(int userId);

}