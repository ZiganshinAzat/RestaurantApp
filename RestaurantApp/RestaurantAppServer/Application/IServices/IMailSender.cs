using Domain.Entities;
using Infrastructure.Models;

namespace Application.IServices;

public interface IMailSender
{
    Task SendMailAsync(MailRequest mailRequest);
}