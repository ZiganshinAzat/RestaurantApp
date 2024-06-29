//
//  Reservation.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 01.05.2024.
//

import Foundation

struct Reservation: Codable {
    let name: String
    let email: String
    let reservationDate: Date
    let numberOfPeople: Int
    let phoneNumber: String
}
