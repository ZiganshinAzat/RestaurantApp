using Domain.Entities;
using Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data.Repositories;

public class ReviewRepository: IReviewRepository
{
    private readonly AppDbContext appDbContext;

    public ReviewRepository(AppDbContext appDbContext)
    {
        this.appDbContext = appDbContext;
    }
    
    public async Task AddReview(Review review)
    {
        await appDbContext.Reviews.AddAsync(review);
        await appDbContext.SaveChangesAsync();
    }
    
    public async Task<List<Review>> GetAllReviews()
    {
        return await appDbContext.Reviews.ToListAsync();
    }
}