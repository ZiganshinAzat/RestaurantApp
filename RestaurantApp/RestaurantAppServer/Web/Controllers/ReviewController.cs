using System.Security.Claims;
using Application.IServices;
using Domain.Entities;
using Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

[ApiController]
[Route("[controller]")]
public class ReviewsController : ControllerBase
{
    private readonly IReviewRepository _reviewRepository;
    private readonly IReviewService _reviewService;

    public ReviewsController(IReviewRepository reviewRepository, IReviewService reviewService)
    {
        this._reviewRepository = reviewRepository;
        this._reviewService = reviewService;
    }

    [Authorize]
    [HttpPost("addReview")]
    public async Task<IActionResult> AddReview([FromBody] Review review)
    {
        var userId = int.Parse(User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value);

        if (!await _reviewService.CanUserAddReview(userId))
        {
            return BadRequest("You must have at least one served order to add a review.");
        }

        await _reviewRepository.AddReview(review);
        return Ok();
    }
    
    [HttpGet("getAllReviews")]
    public async Task<IActionResult> GetAllReviews()
    {
        var reviews = await _reviewRepository.GetAllReviews();
        if (reviews == null || reviews.Count == 0)
        {
            return NotFound("No reviews found.");
        }

        return Ok(reviews);
    }
}
