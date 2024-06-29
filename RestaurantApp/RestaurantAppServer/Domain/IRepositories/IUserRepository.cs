using Domain.Entities;

namespace Domain.Repositories;

public interface IUserRepository
{
    public Task<User?> GetByEmail(string email);
    public Task<User> AddUser(User newUser);
}