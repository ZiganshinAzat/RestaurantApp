//
//  UserDefaultsManager.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 05.05.2024.
//

import Foundation

import Foundation

struct UserDefaultsManager {
    static let userDefaults = UserDefaults.standard

    static func saveUserId(_ userId: Int) {
        userDefaults.set(userId, forKey: "userId")
    }

    static func loadUserId() -> Int {
        return userDefaults.integer(forKey: "userId")
    }

    static func saveIsAdmin(_ isAdmin: Bool) {
        userDefaults.set(isAdmin, forKey: "isAdmin")
    }

    static func loadIsAdmin() -> Bool {
        return userDefaults.bool(forKey: "isAdmin")
    }

    static func clearUserData() {
        userDefaults.removeObject(forKey: "userId")
        userDefaults.removeObject(forKey: "isAdmin")
    }
}
