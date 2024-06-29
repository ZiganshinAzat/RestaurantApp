using Application.IServices;
using Domain.Entities;
using Domain.Repositories;

namespace Infrastructure.Services;

public class UserService(IUserRepository userRepository): IUserService
{
    public async Task<User?> LoginUser(User inputUser)
    {
        var user = await userRepository.GetByEmail(inputUser.Email);
        if (user is null)
        {
            return null;
        }

        if (PasswordHasher.Verify(inputUser.Password, user.Password))
        {
            return user;
        }

        return null;
    }
    public async Task<User> RegisterUser(User newUser)
    {
        var existingUser = await userRepository.GetByEmail(newUser.Email);
        if (existingUser != null)
        {
            return null;
        }

        newUser.Password = PasswordHasher.Hash(newUser.Password);
        return await userRepository.AddUser(newUser);
    }
}