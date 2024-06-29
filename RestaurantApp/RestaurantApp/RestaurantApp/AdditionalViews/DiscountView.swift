//
//  DiscountView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 28.04.2024.
//

import UIKit

class DiscountView: UIView {

    lazy var offerLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var discountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var orderButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Заказать", for: .normal)
        return button
    }()

    lazy var backgroundImageView: UIImageView = {

        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiscountView {
    func setupLayout() {
        backgroundColor = .red
        addSubview(backgroundImageView)
        addSubview(offerLabel)
        addSubview(discountLabel)
        addSubview(orderButton)

        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            offerLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10),
            offerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            offerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            discountLabel.topAnchor.constraint(equalTo: offerLabel.bottomAnchor, constant: 10),
            discountLabel.leadingAnchor.constraint(equalTo: offerLabel.leadingAnchor),
            discountLabel.trailingAnchor.constraint(equalTo: offerLabel.trailingAnchor),

            orderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            orderButton.leadingAnchor.constraint(equalTo: offerLabel.leadingAnchor),
            orderButton.trailingAnchor.constraint(equalTo: offerLabel.trailingAnchor),
        ])
    }
}
