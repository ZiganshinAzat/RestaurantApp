using System.Security.Claims;
using Application.IServices;
using Domain.Entities;
using Domain.Repositories;
using Infrastructure.Models;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

[Route("[controller]")]
[ApiController]
public class ReservationsController : ControllerBase
{
    private readonly IReservationRepository _reservationRepository;
    private readonly IMailSender _mailSender;

    public ReservationsController(IReservationRepository reservationRepository, IMailSender _mailSender)
    {
        this._reservationRepository = reservationRepository;
        this._mailSender = _mailSender;
    }
    
    [HttpPost("addReservation")]
    public async Task<IActionResult> PostReservation([FromBody] Reservation reservation)
    {
        Console.WriteLine("Adding Reservation");
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        await _reservationRepository.AddReservation(reservation);
        
        var mailRequest = new MailRequest
        {
            ToEmail = reservation.Email,  
            Subject = "Reservation Confirmation",
            Body = $"Dear {reservation.Name}, your reservation for {reservation.ReservationDate} has been successfully booked."
        };

        try
        {
            await _mailSender.SendMailAsync(mailRequest);
            Console.WriteLine("Email sent successfully.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Failed to send email: {ex.Message}");
            return StatusCode(500, "Failed to send confirmation email.");
        }

        return Ok();
    }
}