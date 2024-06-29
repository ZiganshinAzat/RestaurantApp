namespace Application.IServices;

public interface IReviewService
{
    Task<bool> CanUserAddReview(int userId);
}