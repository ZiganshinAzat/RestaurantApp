//
//  AddReviewViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import Foundation

class AddReviewViewModel {

    private let restaurantAPIManager: RestaurantAPIManager

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func addReview(review: Review) async throws {
        try await restaurantAPIManager.addReview(review: review)
    }
}
