//
//  OrderViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 04.05.2024.
//

import Foundation

class OrderViewModel {
    
    private let restaurantAPIManager: RestaurantAPIManager

    @Published var orderItems: [OrderItem] = []
    @Published var totalSum: Decimal = 0

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func getOrderItemsForUser(userId: Int) async {
        do {
            orderItems = try await restaurantAPIManager.getOrderItemsByUserId(userId: userId)
            totalSum = getTotalSum(orderItems: orderItems)
        }
        catch {
            orderItems = []
            totalSum = 0
            print("Ошибка getOrderItemsForUser: \(error)")
        }
    }

    private func getTotalSum(orderItems: [OrderItem]) -> Decimal {
        return orderItems.reduce(Decimal(0)) { total, item in
            let price = item.dish.price
            let quantity = Decimal(item.quantity)
            
            return total + (price * quantity)
        }
    }

    func addOrder(order: Order) async {
        do {
            try await restaurantAPIManager.addOrder(order: order)
            await getOrderItemsForUser(userId: order.userId)
        }
        catch {
            print("Ошибка addOrder: \(error)")
        }
    }
}
