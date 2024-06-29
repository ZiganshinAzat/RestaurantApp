using Domain.Entities;
using Domain.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

[ApiController]
[Route("[controller]")]
public class DishesController : ControllerBase
{
    private readonly IDishRepository dishRepository;

    public DishesController(IDishRepository dishRepository)
    {
        this.dishRepository = dishRepository;
    }

    [HttpGet("getAllDishes")]
    public async Task<ActionResult<List<Dish>>> GetAllDishes()
    {
        if (Request.Cookies.Count > 0)
        {
            Console.WriteLine("Received cookies:");
            foreach (var cookie in Request.Cookies)
            {
                Console.WriteLine($"{cookie.Key}: {cookie.Value}");
            }
        }
        else
        {
            Console.WriteLine("No cookies received.");
        }
        
        var dishes = await dishRepository.GetAllDishes();
        return Ok(dishes);
    }
}
