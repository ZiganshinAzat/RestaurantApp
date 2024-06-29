//
//  LoginView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit

class LoginView: UIView {

    lazy var foodiesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.text = "Foodies"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    lazy var loginLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Login"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    lazy var emailTextField: UITextField = {
        getTextField(with: "Email")
    }()

    lazy var passwordTextField: UITextField = {
        let textField = getTextField(with: "Пароль")
        textField.isSecureTextEntry = true
        return textField
    }()

    lazy var loginButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 20
        button.setTitle("Войти", for: .normal)

        let action = UIAction { [weak self] _ in
            guard let self = self else { return }

            if let loginButtonAction = self.loginButtonAction {
                guard let email = emailTextField.text,
                      let password = passwordTextField.text else { return }
                let user = User(id: 0, email: email.lowercased(), password: password, isAdmin: false)
                loginButtonAction(user)
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var loginButtonAction: ((User) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {

    func setupLayout() {

        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(foodiesLabel)
        addSubview(loginLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)

        NSLayoutConstraint.activate([
            foodiesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            foodiesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            loginLabel.topAnchor.constraint(equalTo: foodiesLabel.bottomAnchor, constant: 10),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            loginButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }

    private func getTextField(with placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 40/255, green: 42/255, blue: 60/255, alpha: 1.0).cgColor
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.textColor = .black
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 45/255, green: 50/255, blue: 77/255, alpha: 1.0)]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder

        return textField
    }
}
