//
//  AdminTableViewCell.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit

class AdminTableViewCell: UITableViewCell {

    lazy var orderIdLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    lazy var userIdLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    lazy var statusLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    lazy var totalLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    lazy var nextStepButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Next step", for: .normal)

        let action = UIAction { [weak self] _ in
            if let nextStepButtonAction = self?.nextStepButtonAction {
                nextStepButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    lazy var cancelButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Cancel", for: .normal)

        let action = UIAction { [weak self] _ in

            if let cancelButtonAction = self?.cancelButtonAction {
                cancelButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var nextStepButtonAction: (() -> Void)?
    var cancelButtonAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdminTableViewCell {

    func configureCell(order: Order) {
        orderIdLabel.text = "OrderId: \(order.id)"
        userIdLabel.text = "UserId: \(order.userId)"
        statusLabel.text = "Status: \(order.status)"
        totalLabel.text = "Total: \(order.totalAmount)"
    }

    func setupLayout() {
        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(orderIdLabel)
        addSubview(userIdLabel)
        addSubview(statusLabel)
        addSubview(totalLabel)
        contentView.addSubview(nextStepButton)
        contentView.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            orderIdLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            orderIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            userIdLabel.topAnchor.constraint(equalTo: orderIdLabel.bottomAnchor, constant: 5),
            userIdLabel.leadingAnchor.constraint(equalTo: orderIdLabel.leadingAnchor),

            statusLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor, constant: 5),
            statusLabel.leadingAnchor.constraint(equalTo: orderIdLabel.leadingAnchor),

            totalLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            totalLabel.leadingAnchor.constraint(equalTo: orderIdLabel.leadingAnchor),

            nextStepButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            nextStepButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nextStepButton.heightAnchor.constraint(equalToConstant: 40),
            nextStepButton.widthAnchor.constraint(equalToConstant: 120),

            cancelButton.trailingAnchor.constraint(equalTo: nextStepButton.trailingAnchor),
            cancelButton.topAnchor.constraint(equalTo: nextStepButton.bottomAnchor, constant: 5),
            cancelButton.heightAnchor.constraint(equalTo: nextStepButton.heightAnchor),
            cancelButton.widthAnchor.constraint(equalTo: nextStepButton.widthAnchor)
        ])
    }
}
