//
//  Order.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import Foundation

struct Order: Codable {
    let id: Int
    let userId: Int
    let user: User?
    let orderItems: [OrderItem]?
    let status: OrderStatus
    let totalAmount: Decimal
}
