namespace Application.IServices;

public interface IOrderService
{
    public Task<int> DecreaseOrderItemQuantity(int userId, int dishId);
}