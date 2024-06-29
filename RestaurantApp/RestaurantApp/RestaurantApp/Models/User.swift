//
//  User.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let password: String
    let isAdmin: Bool
}
