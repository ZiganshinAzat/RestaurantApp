//
//  RestaurantAPIManager.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 30.04.2024.
//

import Foundation

protocol RestaurantAPIManager {
    func getAllDishes() async throws -> [Dish]
    func addReservation(reservation: Reservation) async throws 
    func registerUser(user: User) async throws -> User?
    func loginUser(user: User) async throws -> User?
    func addOrderItem(orderItem: OrderItem) async throws -> Int
    func getOrderItemsByUserId(userId: Int) async throws -> [OrderItem]
    func removeOrderItem(orderItem: OrderItem) async throws -> Int
    func addOrder(order: Order) async throws
    func getActiveOrders() async throws -> [Order]
    func advanceOrderStatus(orderId: Int) async throws 
    func cancelOrder(orderId: Int) async throws
    func addReview(review: Review) async throws
    func getAllReviews() async throws -> [Review]
}
