using Application.IServices;
using Domain.Enums;
using Domain.Repositories;

namespace Infrastructure.Services;

public class ReviewService: IReviewService
{
    private readonly IOrderRepository _orderRepository;
    private readonly IReviewRepository _reviewRepository;

    public ReviewService(IOrderRepository orderRepository, IReviewRepository reviewRepository)
    {
        _orderRepository = orderRepository;
        _reviewRepository = reviewRepository;
    }

    public async Task<bool> CanUserAddReview(int userId)
    {
        var orders = await _orderRepository.GetOrdersByUserId(userId);
        return orders.Any(o => o.Status == OrderStatus.Served);
    }
}