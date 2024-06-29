//
//  LoginViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import Foundation

class LoginViewModel {
    
    private let restaurantAPIManager: RestaurantAPIManager

    @Published var user: User?

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func loginUser(user: User) async throws {
        self.user = try await restaurantAPIManager.loginUser(user: user)
    }
}
