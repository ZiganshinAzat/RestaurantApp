//
//  ReservationViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 01.05.2024.
//

import UIKit

class ReservationViewController: UIViewController {

    private let reservationView = ReservationView()
    private let reservationViewModel: ReservationViewModel

    init(reservationViewModel: ReservationViewModel) {
        self.reservationViewModel = reservationViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = reservationView
        reservationView.addReservationButtonAction = addReservation
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Бронирование"
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
    }
}

extension ReservationViewController {

    func addReservation(reservation: Reservation) {
        Task {
            await reservationViewModel.addReservation(reservation: reservation)
            showBookingCreatedAlert()
        }
    }

    func showBookingCreatedAlert() {
        let alert = UIAlertController(title: "Booking Created", message: "Your reservation has been successfully created.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))

        present(alert, animated: true, completion: nil)
    }
}
