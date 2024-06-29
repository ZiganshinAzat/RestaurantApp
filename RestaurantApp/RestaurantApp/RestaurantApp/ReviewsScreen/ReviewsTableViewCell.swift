//
//  ReviewsTableViewCell.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    private lazy var rating: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(nameLabel)
        addSubview(titleLabel)
        addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }

    func configureCell(with review: Review) {
        nameLabel.text = review.name
        titleLabel.text = review.title
        bodyLabel.text = review.body
        configureRating(with: review.rating)
    }

    private func configureRating(with rating: Int) {
        switch rating {
        case 5:
            self.rating = StarsBuilder().addStar().addStar().addStar().addStar().addStar()   .buildStars(withStarsSize: 12)
        case 4:
            self.rating = StarsBuilder().addStar().addStar().addStar().addStar()   .buildStars(withStarsSize: 12)
        case 3:
            self.rating = StarsBuilder().addStar().addStar().addHalfStar()   .buildStars(withStarsSize: 12)
        case 2:
            self.rating = StarsBuilder().addStar().addStar()
                .buildStars(withStarsSize: 12)
        case 1:
            self.rating = StarsBuilder().addStar()
                .buildStars(withStarsSize: 12)
        default:
            break
        }

        self.rating.translatesAutoresizingMaskIntoConstraints = false
        addSubview(self.rating)

        NSLayoutConstraint.activate([
            self.rating.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            self.rating.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
    }
}
