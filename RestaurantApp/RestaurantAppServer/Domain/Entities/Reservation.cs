using System;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities;

public class Reservation
{
    [Key]
    public int Id { get; set; }

    [Required(ErrorMessage = "Name is required")]
    [StringLength(100, ErrorMessage = "Name must not exceed 100 characters")]
    public string Name { get; set; }

    [Required(ErrorMessage = "Email address is required")]
    [EmailAddress(ErrorMessage = "Invalid Email Address")]
    public string Email { get; set; }

    [Required(ErrorMessage = "Reservation date is required")]
    public DateTime ReservationDate { get; set; }

    [Required(ErrorMessage = "Number of people is required")]
    [Range(1, 100, ErrorMessage = "Number of people must be between 1 and 100")]
    public int NumberOfPeople { get; set; }

    [Required(ErrorMessage = "Phone number is required")]
    [Phone(ErrorMessage = "Invalid Phone Number")]
    [StringLength(15, ErrorMessage = "Phone number must not exceed 15 characters")]
    public string PhoneNumber { get; set; }
}