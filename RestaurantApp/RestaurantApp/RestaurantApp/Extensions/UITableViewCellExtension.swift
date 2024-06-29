//
//  UITableViewCellExtension.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 29.04.2024.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
