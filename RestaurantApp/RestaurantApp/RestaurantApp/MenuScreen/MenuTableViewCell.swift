//
//  MenuTableViewCell.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 29.04.2024.
//

import UIKit
import Kingfisher

class MenuTableViewCell: UITableViewCell {

    lazy var dishNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var dishDescriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var priceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    lazy var addToOrderButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)

        let action = UIAction { [weak self] _ in
            if let addToOrderButtonAction = self?.addToOrderButtonAction {
                addToOrderButtonAction()
            } else {
                print("No action for addToOrderButton")
            }
        }

        button.addAction(action, for: .touchUpInside)

        return button
    }()

    lazy var removeFromOrderButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minus"), for: .normal)

        let action = UIAction { [weak self] _ in
            if let removeFromOrderButtonAction = self?.removeFromOrderButtonAction {
                removeFromOrderButtonAction()
            } else {
                print("No action for addToOrderButton")
            }
        }

        button.addAction(action, for: .touchUpInside)

        return button
    }()

    lazy var countLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "0"

        return label
    }()

    lazy var dishImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    var addToOrderButtonAction: (() -> Void)?
    var removeFromOrderButtonAction: (() -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()

        roundRightCornersOfImageView(dishImageView)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuTableViewCell {

    func updateQuantityLabel(with quantity: Int) {
        countLabel.text = "\(quantity)"
    }

    func setupLayout() {
        contentView.addSubview(dishNameLabel)
        contentView.addSubview(dishDescriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToOrderButton)
        contentView.addSubview(dishImageView)
        contentView.addSubview(countLabel)
        contentView.addSubview(removeFromOrderButton)

        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            dishNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dishNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -135),

            dishDescriptionLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 10),
            dishDescriptionLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),
            dishDescriptionLabel.trailingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor),

            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            priceLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),

            addToOrderButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            addToOrderButton.trailingAnchor.constraint(equalTo: dishImageView.leadingAnchor, constant: -20),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 26),
            addToOrderButton.widthAnchor.constraint(equalTo: addToOrderButton.heightAnchor),

            countLabel.centerYAnchor.constraint(equalTo: addToOrderButton.centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: addToOrderButton.leadingAnchor, constant: -5),

            removeFromOrderButton.bottomAnchor.constraint(equalTo: addToOrderButton.bottomAnchor),
            removeFromOrderButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -5),
            removeFromOrderButton.heightAnchor.constraint(equalTo: addToOrderButton.heightAnchor),
            removeFromOrderButton.widthAnchor.constraint(equalTo: addToOrderButton.widthAnchor),

            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            dishImageView.leadingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor, constant: 5)
        ])
    }

    func configureCell(with dish: Dish) {
        dishNameLabel.text = dish.name
        dishDescriptionLabel.text = dish.description
        priceLabel.text = "\(dish.price)" + " ₽"
        dishImageView.kf.setImage(with: dish.image)
    }

    func roundRightCornersOfImageView(_ imageView: UIImageView) {
        let path = UIBezierPath(roundedRect: imageView.bounds,
                                byRoundingCorners: [.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        imageView.layer.mask = maskLayer
    }
}
