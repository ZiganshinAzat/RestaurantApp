//
//  TabBarController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 28.04.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsManager.clearUserData()

        self.tabBar.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        self.tabBar.barTintColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        self.tabBar.isTranslucent = false 
        self.tabBar.tintColor = .systemGreen

        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: .restaurant, tag: 0)

        let menuViewModel = MenuViewModel(restaurantAPIManager: FoodiesAPIManager())
        let menuViewController = MenuViewController(menuViewModel: menuViewModel)
        menuViewController.tabBarItem = UITabBarItem(title: "Menu", image: .menu, tag: 1)

        let orderViewModel = OrderViewModel(restaurantAPIManager: FoodiesAPIManager())
        let orderViewController = OrderViewController(orderViewModel: orderViewModel)
        orderViewController.tabBarItem = UITabBarItem(title: "Order", image: .order, tag: 2)

        let reviewsViewModel = ReviewsViewModel(restaurantAPIManager: FoodiesAPIManager())
        let reviewsViewController = ReviewsViewController(reviewsViewModel: reviewsViewModel)
        reviewsViewController.tabBarItem = UITabBarItem(title: "Reviews", image: .review, tag: 3)

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: .profile, tag: 4)

        self.viewControllers = [
            UINavigationController(rootViewController: homeViewController), 
            menuViewController,
            orderViewController,
            UINavigationController(rootViewController: reviewsViewController),
            UINavigationController(rootViewController: profileViewController),
        ]
    }
}
