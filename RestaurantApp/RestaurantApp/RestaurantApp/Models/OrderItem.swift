//
//  OrderItem.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 05.05.2024.
//

import Foundation

struct OrderItem: Codable {
    let id: Int
    let quantity: Int
    let userId: Int
    let dishId: Int
    let dish: Dish
}
