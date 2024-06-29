using Domain.Entities;

namespace Domain.Repositories;

public interface IOrderItemRepository
{
    public Task AddOrderItem(OrderItem orderItem);
    public Task<List<OrderItem>> GetOrderItemsByUserId(int userId);
    public Task ClearCartForUser(int userId);
    public Task UpdateOrderItem(OrderItem orderItem);
    public Task<OrderItem> FindByUserIdAndDishId(int userId, int dishId);
    public Task DeleteOrderItem(OrderItem orderItem);
}