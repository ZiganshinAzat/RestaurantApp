//
//  ViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 28.04.2024.
//

import UIKit

class HomeViewController: UIViewController {

    private var homeView = HomeView()

    override func loadView() {
        view = homeView
        homeView.bookButtonAction = navigateToReservation
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomeViewController {

    func navigateToReservation() {
        let reservationViewModel = ReservationViewModel(restaurantAPIManager: FoodiesAPIManager())
        self.navigationController?.pushViewController(ReservationViewController(reservationViewModel: reservationViewModel), animated: true)
    }
}
