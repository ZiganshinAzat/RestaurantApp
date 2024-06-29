//
//  DishCategoryView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 28.04.2024.
//

import UIKit

class DishCategoryView: UIView {

    lazy var dishImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    init(dishImage: UIImage?, title: String) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        configureView(with: dishImage, title: title)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView(with dishImage: UIImage?, title: String) {
        dishImageView.image = dishImage
        titleLabel.text = title
    }
}

extension DishCategoryView {
    func setupLayout() {
        backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 220/255.0, alpha: 1.0)

        addSubview(dishImageView)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dishImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dishImageView.heightAnchor.constraint(equalToConstant: 60),
            dishImageView.widthAnchor.constraint(equalTo: dishImageView.heightAnchor),

            titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
