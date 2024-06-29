//
//  RegistrationView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit

class RegistrationView: UIView {

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

    lazy var registrationLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Registration"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    lazy var emailTextField: UITextField = {
        getTextField(with: "Email")
    }()

    lazy var passwordTextField: UITextField = {
        getTextField(with: "Пароль")
    }()

    lazy var registerButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 20
        button.setTitle("Зарегистрироваться", for: .normal)

        let action = UIAction { [weak self] _ in
            self?.registerButtonTapped()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var registerButtonAction: ((User) -> Void)?
    var showEmailAlert: (() -> Void)?
    var showPasswordAlert: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegistrationView {

    private func registerButtonTapped() {
        guard validate() else { return }

        if let registerButtonAction {
            let user = User(id: 0, email: emailTextField.text!.lowercased(), password: passwordTextField.text!, isAdmin: false)
            registerButtonAction(user)
        } else {
            print("No action")
        }
    }

    private func validate() -> Bool {
        var isValid = true

        if let email = emailTextField.text, isValidEmail(email) {
            emailTextField.applyNormalStyle()
        } else {
            emailTextField.applyErrorStyle()
            showEmailAlert?()
            isValid = false
        }

        if let password = passwordTextField.text, isValidPassword(password) {
            passwordTextField.applyNormalStyle()
        } else {
            passwordTextField.applyErrorStyle()
            showPasswordAlert?()
            isValid = false
        }

        return isValid
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$&*]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }

    func setupLayout() {

        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(foodiesLabel)
        addSubview(registrationLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)

        NSLayoutConstraint.activate([
            foodiesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            foodiesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            registrationLabel.topAnchor.constraint(equalTo: foodiesLabel.bottomAnchor, constant: 10),
            registrationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            registerButton.heightAnchor.constraint(equalToConstant: 46)
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
