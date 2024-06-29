//
//  HomeView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 28.04.2024.
//

import UIKit

class HomeView: UIView {

    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .gray
        scrollView.showsVerticalScrollIndicator = false
        // scrollView.alwaysBounceVertical = false
        scrollView.backgroundColor = .white

        return scrollView
    }()

    lazy var contentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.text = "Welcome Foodies"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Откройте мир вкуса!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var secondaryTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Выберите блюдо, забронируйте столик и наслаждайтесь каждым моментом."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var bookButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Забронировать столик", for: .normal)

        let action = UIAction { [weak self] _ in

            if let bookButtonAction = self?.bookButtonAction {
                bookButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    lazy var dinnerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dinner"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var pancakeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pancake"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var burgerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "burger"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var broccoliImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "broccoli"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    var dishCategoriesFirstRowStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        return stackView
    }()

    var dishCategoriesSecondRowStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        return stackView
    }()

    var firstDiscountView: DiscountView = {
        let view = DiscountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundImageView.image = UIImage(named: "discount1")
        view.offerLabel.textColor = .white
        view.offerLabel.text = "Special offer"

        view.discountLabel.textColor = .white
        view.discountLabel.text = "Upto 50% Off"

        return view
    }()

    var secondDiscountView: DiscountView = {
        let view = DiscountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundImageView.image = UIImage(named: "discount2")
        view.offerLabel.textColor = .black
        view.offerLabel.text = "Special offer"

        view.discountLabel.textColor = .black
        view.discountLabel.text = "Upto 25% Extra"

        return view
    }()

    var thirdDiscountView: DiscountView = {
        let view = DiscountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundImageView.image = UIImage(named: "discount3")
        view.offerLabel.textColor = .white
        view.offerLabel.text = "Limited offer"

        view.discountLabel.textColor = .white
        view.discountLabel.text = "100% Cashback"

        return view
    }()

    var discountStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually

        return stackView
    }()

    var bookButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView {
    func setupLayout() {
        scrollView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        dishCategoriesFirstRowStackView.addArrangedSubview(DishCategoryView(dishImage: UIImage(named: "salad"), title: "Салаты"))
        dishCategoriesFirstRowStackView.addArrangedSubview(DishCategoryView(dishImage: UIImage(named: "soup"), title: "Супы"))
        dishCategoriesFirstRowStackView.addArrangedSubview(DishCategoryView(dishImage: UIImage(named: "meal"), title: "Горячие блюда"))

        for view in dishCategoriesFirstRowStackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 90),
            ])
            view.layer.cornerRadius = 10
        }

        dishCategoriesSecondRowStackView.addArrangedSubview(DishCategoryView(dishImage: UIImage(named: "pasta"), title: "Паста"))
        dishCategoriesSecondRowStackView.addArrangedSubview(DishCategoryView(dishImage: UIImage(named: "dessert"), title: "Десерты"))
        dishCategoriesSecondRowStackView.addArrangedSubview(DishCategoryView(dishImage: UIImage(named: "drink"), title: "Напитки"))

        for view in dishCategoriesSecondRowStackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 90),
            ])
            view.layer.cornerRadius = 10
        }

        discountStackView.addArrangedSubview(firstDiscountView)
        discountStackView.addArrangedSubview(secondDiscountView)
        discountStackView.addArrangedSubview(thirdDiscountView)

        for view in discountStackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 200),
            ])
            view.layer.cornerRadius = 10
        }

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(secondaryTitleLabel)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(bookButton)
        contentView.addSubview(dinnerImageView)
        contentView.addSubview(pancakeImageView)
        contentView.addSubview(burgerImageView)
        contentView.addSubview(broccoliImageView)
        contentView.addSubview(dishCategoriesFirstRowStackView)
        contentView.addSubview(dishCategoriesSecondRowStackView)
        contentView.addSubview(discountStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            welcomeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),

            titleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -150),

            secondaryTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            secondaryTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            secondaryTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 30),

            bookButton.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            bookButton.topAnchor.constraint(equalTo: secondaryTitleLabel.bottomAnchor, constant: 20),
            bookButton.heightAnchor.constraint(equalToConstant: 40),
            bookButton.widthAnchor.constraint(equalToConstant: 200),

            dinnerImageView.leadingAnchor.constraint(equalTo: bookButton.trailingAnchor, constant: 50),
            dinnerImageView.centerYAnchor.constraint(equalTo: bookButton.centerYAnchor),
            dinnerImageView.heightAnchor.constraint(equalToConstant: 80),
            dinnerImageView.widthAnchor.constraint(equalTo: dinnerImageView.heightAnchor),

            pancakeImageView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            pancakeImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -40),
            pancakeImageView.heightAnchor.constraint(equalToConstant: 60),
            pancakeImageView.widthAnchor.constraint(equalTo: pancakeImageView.heightAnchor),

            burgerImageView.leadingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor, constant: 30),
            burgerImageView.topAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: 0),
            burgerImageView.heightAnchor.constraint(equalToConstant: 80),
            burgerImageView.widthAnchor.constraint(equalTo: burgerImageView.heightAnchor),

            broccoliImageView.leadingAnchor.constraint(equalTo: secondaryTitleLabel.trailingAnchor, constant: 0),
            broccoliImageView.topAnchor.constraint(equalTo: secondaryTitleLabel.topAnchor, constant: 0),
            broccoliImageView.heightAnchor.constraint(equalToConstant: 60),
            broccoliImageView.widthAnchor.constraint(equalTo: burgerImageView.heightAnchor),

            dishCategoriesFirstRowStackView.topAnchor.constraint(equalTo: bookButton.bottomAnchor, constant: 50),
            dishCategoriesFirstRowStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dishCategoriesFirstRowStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            dishCategoriesSecondRowStackView.topAnchor.constraint(equalTo: dishCategoriesFirstRowStackView.bottomAnchor, constant: 10),
            dishCategoriesSecondRowStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dishCategoriesSecondRowStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            discountStackView.leadingAnchor.constraint(equalTo: dishCategoriesFirstRowStackView.leadingAnchor),
            discountStackView.trailingAnchor.constraint(equalTo: dishCategoriesFirstRowStackView.trailingAnchor),
            discountStackView.topAnchor.constraint(equalTo: dishCategoriesSecondRowStackView.bottomAnchor, constant: 30)

        ])

        let bottomSubviewBottomConstraint = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: discountStackView, attribute: .bottom, multiplier: 1.0, constant: 50)
        bottomSubviewBottomConstraint.priority = .defaultHigh
        bottomSubviewBottomConstraint.isActive = true
    }
}
