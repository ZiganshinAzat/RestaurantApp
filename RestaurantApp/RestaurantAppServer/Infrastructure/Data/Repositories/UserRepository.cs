using Domain.Entities;
using Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data.Repositories;

public class UserRepository(AppDbContext appDbContext): IUserRepository
{
    public Task<User?> GetByEmail(string email)
    {
        return appDbContext.Users.SingleOrDefaultAsync(user => user.Email == email);
    }
    
    public async Task<User> AddUser(User newUser)
    {
        await appDbContext.Users.AddAsync(newUser);
        await appDbContext.SaveChangesAsync();
        return newUser;
    }
}