//
//  RegLogView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit

class RegLogView: UIView {

    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.text = "Welcome to Foodies"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    lazy var loginButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 20
        button.setTitle("Log In", for: .normal)

        let action = UIAction { [weak self] _ in

            if let logInButtonAction = self?.logInButtonAction {
                logInButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    lazy var signupButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 40/255, green: 42/255, blue: 60/255, alpha: 1.0).cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 20
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)

        let action = UIAction { [weak self] _ in

            if let signUpButtonAction = self?.signUpButtonAction {
                signUpButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    lazy var managerButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitle("I am Admin", for: .normal)
        button.setTitleColor(UIColor.systemGreen, for: .normal)

        let action = UIAction { [weak self] _ in

            if let managerButtonAction = self?.managerButtonAction {
                managerButtonAction()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var logInButtonAction: (() -> Void)?
    var signUpButtonAction: (() -> Void)?
    var managerButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RegLogView {
    func setupLayout() {

        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(welcomeLabel)
        addSubview(loginButton)
        addSubview(signupButton)
        addSubview(managerButton)

        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            loginButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            loginButton.heightAnchor.constraint(equalToConstant: 46),

            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signupButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            signupButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),

            managerButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 10),
            managerButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
