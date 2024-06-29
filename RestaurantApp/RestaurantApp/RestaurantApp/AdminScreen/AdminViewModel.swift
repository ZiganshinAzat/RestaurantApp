//
//  AdminViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import Foundation
import Combine

class AdminViewModel {
    
    private let restaurantAPIManager: RestaurantAPIManager

    @Published var activeOrders: [Order] = []

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func getActiveOrders() async {
        do {
            activeOrders = try await restaurantAPIManager.getActiveOrders()
        }
        catch {
            activeOrders = []
            print("Ошибка getMenuDishes: \(error)")
        }
    }

    func advanceOrderStatus(orderId: Int) async {
        do {
            try await restaurantAPIManager.advanceOrderStatus(orderId: orderId)
        }
        catch {
            print("Ошибка advanceOrderStatus: \(error)")
        }
    }

    func cancelOrder(orderId: Int) async {
        do {
            try await restaurantAPIManager.cancelOrder(orderId: orderId)
        }
        catch {
            print("Ошибка advanceOrderStatus: \(error)")
        }
    }
}
