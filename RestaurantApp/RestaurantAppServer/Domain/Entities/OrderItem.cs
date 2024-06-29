using System.ComponentModel.DataAnnotations;

namespace Domain.Entities;

public class OrderItem
{
    [Key]
    public int Id { get; set; }
    public int Quantity { get; set; }

    public int UserId { get; set; }
    
    public int DishId { get; set; }
    public Dish Dish { get; set; }
}