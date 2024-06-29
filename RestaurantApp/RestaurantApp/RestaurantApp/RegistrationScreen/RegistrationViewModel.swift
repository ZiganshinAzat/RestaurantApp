//
//  RegistrationViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit

class RegistrationViewModel {

    private let restaurantAPIManager: RestaurantAPIManager

    @Published var user: User?

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func registerUser(user: User) async throws {
        self.user = try await restaurantAPIManager.registerUser(user: user)
    }
}
