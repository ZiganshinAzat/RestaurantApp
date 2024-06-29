//
//  MenuViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 30.04.2024.
//

import Foundation
import Combine

class MenuViewModel {

    private let restaurantAPIManager: RestaurantAPIManager

    @Published var menuDishes: [Dish] = []

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func getMenuDishes() async {
        do {
            menuDishes = try await restaurantAPIManager.getAllDishes()
        }
        catch {
            print("Ошибка getMenuDishes: \(error)")
        }
    }

    func addOrderItem(orderItem: OrderItem) async -> Int {
        do {
            return try await restaurantAPIManager.addOrderItem(orderItem: orderItem)
        }
        catch {
            print("Ошибка addOrderItem: \(error)")
            return 0
        }
    }

    func removeOrderItem(orderItem: OrderItem) async -> Int {
        do {
            return try await restaurantAPIManager.removeOrderItem(orderItem: orderItem)
        }
        catch {
            print("Ошибка addOrderItem: \(error)")
            return 0
        }
    }
}
