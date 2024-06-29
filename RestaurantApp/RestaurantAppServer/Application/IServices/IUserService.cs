using Domain.Entities;

namespace Application.IServices;

public interface IUserService
{
    public Task<User?> LoginUser(User user);
    public Task<User> RegisterUser(User newUser);
}
