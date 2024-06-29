//
//  OrderView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 04.05.2024.
//

import UIKit

class OrderView: UIView {

    lazy var orderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Ваш заказ"

        return label
    }()

    lazy var orderItemsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OrderItemsTableViewCell.self, forCellReuseIdentifier: OrderItemsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        tableView.separatorStyle = .none

        return tableView
    }()

    lazy var totalLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Итого: "

        return label
    }()

    lazy var orderButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Заказать", for: .normal)

        let action = UIAction { [weak self] _ in

            if let addOrderButtonAction = self?.addOrderButtonAction {
                addOrderButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var addOrderButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderView {
    func setupLayout() {
        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(orderLabel)
        addSubview(orderItemsTableView)
        addSubview(totalLabel)
        addSubview(orderButton)

        NSLayoutConstraint.activate([
            orderLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            orderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            totalLabel.leadingAnchor.constraint(equalTo: orderLabel.leadingAnchor),
            totalLabel.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 10),

            orderItemsTableView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 10),
            orderItemsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            orderItemsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            orderItemsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            orderButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            orderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            orderButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
}
