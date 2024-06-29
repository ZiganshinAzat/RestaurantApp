//
//  ManagerAuthenticationViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import Foundation
import Combine

class ManagerAuthenticationViewModel {
    
    private let restaurantAPIManager: RestaurantAPIManager

    @Published var user: User?

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func loginUser(user: User) async throws {
        self.user = try await restaurantAPIManager.loginUser(user: user)
    }
}
