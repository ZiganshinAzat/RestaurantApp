//
//  AdminViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit
import Combine

class AdminViewController: UIViewController {

    private let adminViewModel: AdminViewModel
    private let adminView = AdminView()
    private var ordersDataSource: [Order] = []
    private var cancellables: Set<AnyCancellable> = []

    init(adminViewModel: AdminViewModel) {
        self.adminViewModel = adminViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = adminView
        adminView.ordersTableView.dataSource = self
        adminView.ordersTableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        setupBindings()
        self.title = "Заказы"
    }

    override func viewWillAppear(_ animated: Bool) {
        Task {
            await adminViewModel.getActiveOrders()
        }
    }
}

extension AdminViewController: UITableViewDelegate, UITableViewDataSource {

    func advanceOrderStatus(orderId: Int) {
        Task {
            await adminViewModel.advanceOrderStatus(orderId: orderId)
            await adminViewModel.getActiveOrders()
            self.adminView.ordersTableView.reloadData()
        }
    }

    func cancelOrder(orderId: Int) {
        Task {
            await adminViewModel.cancelOrder(orderId: orderId)
            await adminViewModel.getActiveOrders()
            self.adminView.ordersTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ordersDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AdminTableViewCell.reuseIdentifier,
            for: indexPath) as? AdminTableViewCell else {
            return UITableViewCell()
        }

        let order = ordersDataSource[indexPath.row]
        cell.selectionStyle = .none
        cell.configureCell(order: order)
        cell.nextStepButtonAction = {
            self.advanceOrderStatus(orderId: order.id)
        }
        cell.cancelButtonAction = {
            self.cancelOrder(orderId: order.id)
        }

        return cell
    }

    func setupBindings() {
        adminViewModel.$activeOrders
            .sink { [weak self] orders in
                guard let self else { return }

                self.ordersDataSource = orders
                DispatchQueue.main.async {
                    self.adminView.ordersTableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var backgroundConfig = cell.defaultBackgroundConfiguration()
        backgroundConfig.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 220/255.0, alpha: 1.0)
        backgroundConfig.cornerRadius = 20
        backgroundConfig.backgroundInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)

        cell.backgroundConfiguration = backgroundConfig

        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.2

        let shadowPath = UIBezierPath(roundedRect: cell.bounds.insetBy(dx: 10, dy: 5), cornerRadius: backgroundConfig.cornerRadius)
        cell.layer.shadowPath = shadowPath.cgPath
    }
}
