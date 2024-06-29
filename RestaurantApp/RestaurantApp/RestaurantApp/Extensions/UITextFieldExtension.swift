//
//  UITextFieldExtension.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 02.05.2024.
//

import Foundation
import UIKit

extension UITextField {
    func applyErrorStyle() {
        self.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        self.layer.borderColor = UIColor.red.cgColor
        self.textColor = UIColor.red
    }

    func applyNormalStyle() {
        self.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        self.layer.borderColor = UIColor(red: 40/255, green: 42/255, blue: 60/255, alpha: 1.0).cgColor
        self.textColor = .black
    }
}
