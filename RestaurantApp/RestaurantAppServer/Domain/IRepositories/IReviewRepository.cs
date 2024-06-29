using Domain.Entities;

namespace Domain.Repositories;

public interface IReviewRepository
{
    public Task AddReview(Review review);
    public Task<List<Review>> GetAllReviews();
}