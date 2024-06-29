using Application.IServices;
using Domain.Repositories;

namespace Infrastructure.Services;

public class OrderService : IOrderService
{
    private readonly IOrderItemRepository _orderItemRepository;

    public OrderService(IOrderItemRepository orderItemRepository)
    {
        _orderItemRepository = orderItemRepository;
    }

    public async Task<int> DecreaseOrderItemQuantity(int userId, int dishId)
    {
        var orderItem = await _orderItemRepository.FindByUserIdAndDishId(userId, dishId);
        if (orderItem == null || orderItem.Quantity <= 0)
        {
            return 0;
        }

        orderItem.Quantity -= 1;
        if (orderItem.Quantity == 0)
        {
            await _orderItemRepository.DeleteOrderItem(orderItem);
        }
        else
        {
            await _orderItemRepository.UpdateOrderItem(orderItem);
        }

        return orderItem.Quantity;
    }
}