using System.Security.Claims;
using Application.IServices;
using Domain.Entities;
using Domain.Repositories;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

[Route("[controller]")]
[ApiController]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;
    private readonly IUserRepository _userRepository;

    public UsersController(IUserService userService, IUserRepository userRepository)
    {
        _userService = userService;
        _userRepository = userRepository;
    }

    [HttpPost("signin")]
    public async Task<IActionResult> SignIn([FromBody] User userLoginModel)
    {
        if (userLoginModel == null)
        {
            return BadRequest("Invalid user data.");
        }

        var user = await _userService.LoginUser(new User { Email = userLoginModel.Email, Password = userLoginModel.Password });
        if (user != null)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Role, user.IsAdmin ? "Admin" : "User")  
            };
            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                new ClaimsPrincipal(claimsIdentity));

            return Ok(user);  
        }
        else
        {
            return Unauthorized();  
        }
    }

    
    [HttpPost("signup")]
    public async Task<IActionResult> SignUp([FromBody] User newUser)
    {
        if (newUser == null)
        {
            return BadRequest("Invalid user data.");
        }

        var registeredUser = await _userService.RegisterUser(newUser);
        if (registeredUser != null)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, registeredUser.Id.ToString()),
                new Claim(ClaimTypes.Role, registeredUser.IsAdmin ? "Admin" : "User")  // Добавляем информацию о роли
            };
            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                new ClaimsPrincipal(claimsIdentity));

            return Ok(registeredUser);
        }
        else
        {
            return BadRequest("User with this username already exists or registration failed.");
        }
    }
}