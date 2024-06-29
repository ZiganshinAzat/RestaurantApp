//
//  OrderViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 04.05.2024.
//

import UIKit
import Combine

class OrderViewController: UIViewController {

    private let orderView = OrderView()
    private let orderViewModel: OrderViewModel
    private var orderItemsDataSource: [OrderItem] = []
    private var cancellables: Set<AnyCancellable> = []

    init(orderViewModel: OrderViewModel) {
        self.orderViewModel = orderViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = orderView
        orderView.orderItemsTableView.dataSource = self
        orderView.orderItemsTableView.delegate = self
        orderView.addOrderButtonAction = addOrderButtonAction
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        Task {
            let userId = UserDefaultsManager.loadUserId()
            await orderViewModel.getOrderItemsForUser(userId: userId)
        }
    }
}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {

    func addOrderButtonAction() {
        let orderItems = orderViewModel.orderItems
        guard !orderItems.isEmpty else { print("Cart is empty"); return }
        Task {
            let userId = UserDefaultsManager.loadUserId()
            let order = Order(id: 0, userId: userId, user: nil, orderItems: orderViewModel.orderItems, status: OrderStatus.created, totalAmount: orderViewModel.totalSum)
            await orderViewModel.addOrder(order: order)
            showOrderPlacedAlert()
        }
    }

    func showOrderPlacedAlert() {
        let alert = UIAlertController(title: "Заказ оформлен", message: "Ваш заказ успешно оформлен и скоро будет обработан. Спасибо, что выбрали наш ресторан!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))
        present(alert, animated: true, completion: nil)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderItemsDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderItemsTableViewCell.reuseIdentifier,
            for: indexPath) as? OrderItemsTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        let orderItem = orderItemsDataSource[indexPath.row]
        cell.configureCell(with: orderItem)

        return cell
    }

    func setupBindings() {
        orderViewModel.$orderItems
            .dropFirst()
            .sink { [weak self] orderItems in
                guard let self else { return }

                self.orderItemsDataSource = orderItems
                DispatchQueue.main.async {
                    self.orderView.orderItemsTableView.reloadData()
                }
            }
            .store(in: &cancellables)

        orderViewModel.$totalSum
            .sink { [weak self] totalSum in
                guard let self else { return }

                DispatchQueue.main.async {
                    self.orderView.totalLabel.text = "Итого: \(totalSum)"
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
