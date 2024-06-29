using System.Security.Claims;
using Application.IServices;
using Domain.Entities;
using Domain.Enums;
using Domain.Repositories;
using Infrastructure.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace Web.Controllers;

[Route("[controller]")]
[ApiController]
[Authorize]
public class OrderController : ControllerBase
{
    private readonly IOrderItemRepository _orderItemRepository;
    private readonly IOrderService _orderService;
    private readonly IOrderRepository _orderRepository;
    private static readonly Dictionary<OrderStatus, OrderStatus?> StatusTransitions = new Dictionary<OrderStatus, OrderStatus?>
    {
        { OrderStatus.Created, OrderStatus.Preparing },
        { OrderStatus.Preparing, OrderStatus.ReadyToServe },
        { OrderStatus.ReadyToServe, OrderStatus.Served },
        { OrderStatus.Served, null }
    };

    public OrderController(IOrderItemRepository orderItemRepository, IOrderService orderService, IOrderRepository orderRepository)
    {
        this._orderItemRepository = orderItemRepository;
        this._orderService = orderService;
        this._orderRepository = orderRepository;
    }
    
    [HttpPost("addOrderItem")]
    public async Task<IActionResult> AddOrderItem([FromBody] OrderItem orderItem)
    {
        if (orderItem == null)
        {
            return BadRequest("Invalid order item.");
        }

        var claimUserId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (claimUserId != orderItem.UserId.ToString())
        {
            return Forbid("You do not have permission.");
        }

        var existingOrderItem = await _orderItemRepository.FindByUserIdAndDishId(orderItem.UserId, orderItem.DishId);
        if (existingOrderItem != null)
        {
            existingOrderItem.Quantity += 1;
            await _orderItemRepository.UpdateOrderItem(existingOrderItem); 
            return Ok(new { Quantity = existingOrderItem.Quantity }); 
        }
        else
        {
            orderItem.Quantity += 1;
            await _orderItemRepository.AddOrderItem(orderItem);
            return Ok(new { Quantity = orderItem.Quantity }); 
        }
    }
    
    [HttpPost("removeOrderItem")]
    public async Task<IActionResult> RemoveOrderItem([FromBody] OrderItem orderItem)
    {
        if (orderItem == null)
        {
            return BadRequest("Invalid order item.");
        }

        var claimUserId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
        if (claimUserId != orderItem.UserId.ToString())
        {
            return Forbid("You do not have permission.");
        }

        var quantity = await _orderService.DecreaseOrderItemQuantity(orderItem.UserId, orderItem.DishId);
            
        return Ok(new { Quantity = quantity });
    }

    
    [HttpGet("GetOrderItemsByUser/{userId}")]
    public async Task<ActionResult<List<OrderItem>>> GetOrderItemsByUserId(int userId)
    {
        var claimUserId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (claimUserId != userId.ToString())
        {
            return Forbid("You do not have permission.");
        }

        var orderItems = await _orderItemRepository.GetOrderItemsByUserId(userId);
        if (orderItems == null || orderItems.Count == 0)
        {
            return NotFound($"No order items found for user with ID {userId}.");
        }

        return Ok(orderItems);
    }
    
    [HttpPost("addOrder")]
    public async Task<IActionResult> AddOrder()
    {
        Console.WriteLine("addOrder");
        string requestBody;
        using (var reader = new StreamReader(Request.Body))
        {
            requestBody = await reader.ReadToEndAsync();
        }

        Order order = JsonConvert.DeserializeObject<Order>(requestBody);
        if (order == null)
        {
            return BadRequest("Invalid order data.");
        }

        var claimUserId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (claimUserId != order.UserId.ToString())
        {
            return Forbid("You do not have permission to create an order for another user.");
        }
    
        await _orderRepository.Add(order);
        await _orderItemRepository.ClearCartForUser(order.UserId);

        return Ok();
    }
    
    [HttpGet("GetActiveOrders")]
    [Authorize(Roles = "Admin")]
    public async Task<ActionResult<List<Order>>> GetActiveOrders()
    {
        var orders = await _orderRepository.GetOrdersExcludingStatuses(new List<OrderStatus> { OrderStatus.Cancelled, OrderStatus.Served });
        if (orders == null || orders.Count == 0)
        {
            return NotFound("No active orders found.");
        }

        return Ok(orders);
    }
    
    [HttpPost("advanceOrderStatus/{orderId}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> AdvanceOrderStatus(int orderId)
    {
        var order = await _orderRepository.FindByIdAsync(orderId);
        if (order == null)
        {
            return NotFound($"Order with ID {orderId} not found.");
        }

        if (StatusTransitions.TryGetValue(order.Status, out var nextStatus))
        {
            if (nextStatus == null)
            {
                return BadRequest("Cannot advance order status as it is already completed.");
            }

            order.Status = nextStatus.Value;
            await _orderRepository.UpdateAsync(order);
            return Ok($"Order status updated to {order.Status}.");
        }

        return BadRequest("Invalid order status transition.");
    }

    [HttpPost("cancelOrder/{orderId}")]
    [Authorize(Roles = "Admin")] 
    public async Task<IActionResult> CancelOrder(int orderId)
    {
        var order = await _orderRepository.FindByIdAsync(orderId);
        if (order == null)
        {
            return NotFound($"Order with ID {orderId} not found.");
        }

        if (order.Status == OrderStatus.Cancelled)
        {
            return BadRequest("Order is already cancelled.");
        }
        if (order.Status == OrderStatus.Served)
        {
            return BadRequest("Cannot cancel an order that has already been served.");
        }

        order.Status = OrderStatus.Cancelled;
        await _orderRepository.UpdateAsync(order);
        return Ok($"Order with ID {orderId} has been cancelled.");
    }
}