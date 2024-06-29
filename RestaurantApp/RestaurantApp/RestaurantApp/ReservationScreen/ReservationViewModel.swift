//
//  ReservationViewModel.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 01.05.2024.
//

import Foundation

class ReservationViewModel {
    
    private let restaurantAPIManager: RestaurantAPIManager

    init(restaurantAPIManager: RestaurantAPIManager) {
        self.restaurantAPIManager = restaurantAPIManager
    }

    func addReservation(reservation: Reservation) async {

        do {
            try await restaurantAPIManager.addReservation(reservation: reservation)
        } 
        catch {
            print("Ошибка: \(error)")
        }
    }
}
