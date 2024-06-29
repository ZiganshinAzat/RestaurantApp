//
//  ReviewsView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit

class ReviewsView: UIView {

    lazy var reviewsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Отзывы"

        return label
    }()

    lazy var reviewsTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReviewsTableViewCell.self, forCellReuseIdentifier: ReviewsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        tableView.separatorStyle = .none

        return tableView
    }()

    lazy var addReviewButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Оставить отзыв", for: .normal)

        let action = UIAction { [weak self] _ in

            if let addReviewButtonAction = self?.addReviewButtonAction {
                addReviewButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var addReviewButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewsView {

    func setupLayout() {
        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        
        addSubview(reviewsLabel)
        addSubview(reviewsTableView)
        addSubview(addReviewButton)

        NSLayoutConstraint.activate([
            reviewsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            reviewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            addReviewButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addReviewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            addReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            addReviewButton.heightAnchor.constraint(equalToConstant: 46),

            reviewsTableView.topAnchor.constraint(equalTo: reviewsLabel.bottomAnchor, constant: 10),
            reviewsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reviewsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reviewsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
