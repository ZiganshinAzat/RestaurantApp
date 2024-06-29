//
//  Review.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import Foundation

struct Review: Codable {
    let id: Int
    let name: String
    let title: String
    let body: String
    let rating: Int
}
