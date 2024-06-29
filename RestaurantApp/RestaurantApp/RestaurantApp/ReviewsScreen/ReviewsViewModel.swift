//
//  ReviewsViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import Foundation

class ReviewsViewModel {

    private let restaurantAPIManager: RestaurantAPIManager

    @Published var reviews: [Review] = []

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func getReviews() async {
        do {
            reviews = try await restaurantAPIManager.getAllReviews()
        }
        catch {
            reviews = []
            print("Ошибка getOrderItemsForUser: \(error)")
        }
    }
}
