//
//  OrderItemsTableViewCell.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 05.05.2024.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {

    lazy var dishImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true

        return imageView
    }()

    lazy var dishNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var priceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    lazy var countLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Кол-во:  "

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderItemsTableViewCell {

    func configureCell(with orderItem: OrderItem) {
        dishImageView.kf.setImage(with: orderItem.dish.image)
        dishNameLabel.text = orderItem.dish.name
        priceLabel.text = "\(orderItem.dish.price * Decimal(orderItem.quantity))" + " ₽"
        countLabel.text = "Кол-во: \(orderItem.quantity)"
    }

    func setupLayout() {
        addSubview(dishImageView)
        addSubview(dishNameLabel)
        addSubview(priceLabel)
        addSubview(countLabel)

        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dishImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            dishImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            dishImageView.widthAnchor.constraint(equalToConstant: 120),

            dishNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            dishNameLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 10),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            countLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 8),
            countLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 10)
        ])
    }
}
