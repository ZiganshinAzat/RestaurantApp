//
//  Dish.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 29.04.2024.
//

import Foundation

struct Dish: Codable {
    let id: Int
    let name: String
    let price: Decimal
    let description: String
    let category: String
    let image: URL?
}
