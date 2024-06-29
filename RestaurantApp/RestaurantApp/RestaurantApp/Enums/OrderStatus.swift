//
//  OrderStatus.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import Foundation

enum OrderStatus: String, Codable {
    case created = "Created"
    case preparing = "Preparing"
    case readyToServe = "ReadyToServe"
    case served = "Served"
    case cancelled = "Cancelled"
}
