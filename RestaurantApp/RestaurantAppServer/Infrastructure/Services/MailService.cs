using Application.Configurations;
using Application.IServices;
using Infrastructure.Models;
using Microsoft.Extensions.Options;
using MimeKit;
using MailKit;
using MailKit.Net.Smtp;
using MailKit.Security;

namespace Infrastructure.Services;

public class MailService: IMailSender
{
    private readonly MailSettings _mailSettings;
    public MailService(IOptions<MailSettings> mailSettings)
    {
        _mailSettings = mailSettings.Value;
    }
    
    public async Task SendMailAsync(MailRequest mailRequest)
    {
        var email = new MimeMessage();
        email.Sender = MailboxAddress.Parse(_mailSettings.Mail);  
        email.From.Add(new MailboxAddress(_mailSettings.DisplayName, _mailSettings.Mail));
        email.To.Add(MailboxAddress.Parse(mailRequest.ToEmail));  
        email.Subject = mailRequest.Subject;                      
        
        var builder = new BodyBuilder
        {
            HtmlBody = mailRequest.Body  
        };

        email.Body = builder.ToMessageBody();  

        using var smtp = new SmtpClient();
        await smtp.ConnectAsync(_mailSettings.Host, _mailSettings.Port, SecureSocketOptions.StartTls);  
        await smtp.AuthenticateAsync(_mailSettings.Mail, _mailSettings.Password);  
        await smtp.SendAsync(email);
        Console.WriteLine("письмо отправлено");
        await smtp.DisconnectAsync(true);  
    }
}