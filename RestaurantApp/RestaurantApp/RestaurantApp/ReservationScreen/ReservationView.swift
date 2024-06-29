//
//  ReservationView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 01.05.2024.
//

import UIKit

class ReservationView: UIView {

    lazy var nameTextField: UITextField = {
        getTextField(with: "Имя")
    }()

    lazy var emailTextField: UITextField = {
        getTextField(with: "Email")
    }()

    lazy var dateTextField: UITextField = {
        let textField = getTextField(with: "Дата и время")

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.timeZone = TimeZone.current
        datePicker.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

        textField.inputView = datePicker
        textField.delegate = self

        return textField
    }()

    lazy var peopleCountTextField: UITextField = {
        let textField = getTextField(with: "Количество гостей")
        textField.keyboardType = .numberPad
        return textField
    }()

    lazy var phoneNumberTextField: UITextField = {
        let textField = getTextField(with: "Номер телефона")
        textField.keyboardType = .numberPad
        return textField
    }()

    lazy var addReservationButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Забронировать", for: .normal)

        let action = UIAction { [weak self] _ in

            if let addReservationButtonAction = self?.addReservationButtonAction {
                self?.createAndSubmitReservation()
            } else {
                print("Не добавлено событие на кнопку")
            }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var addReservationButtonAction: ((Reservation) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReservationView: UITextFieldDelegate {

    private func createAndSubmitReservation() {

        if !validate() {
            print("Валидация не пройдена. Пожалуйста, исправьте ошибки.")
            return
        }
        
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let dateString = dateTextField.text, !dateString.isEmpty,
              let peopleCountString = peopleCountTextField.text, !peopleCountString.isEmpty,
              let numberOfPeople = Int(peopleCountString),
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            print("Все поля должны быть заполнены")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM yyyy 'в' HH:mm"
        dateFormatter.timeZone = TimeZone.current
        guard let reservationDate = dateFormatter.date(from: dateString) else {
            print("Ошибка в формате даты")
            return
        }

        let reservation = Reservation(name: name, email: email.lowercased(), reservationDate: reservationDate, numberOfPeople: numberOfPeople, phoneNumber: phoneNumber)

        addReservationButtonAction?(reservation)
    }

    @objc private func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "d MMM yyyy 'в' HH:mm"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
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

    func setupLayout() {

        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(dateTextField)
        addSubview(peopleCountTextField)
        addSubview(phoneNumberTextField)
        addSubview(addReservationButton)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),

            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            dateTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            dateTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            dateTextField.heightAnchor.constraint(equalToConstant: 50),

            peopleCountTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 15),
            peopleCountTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            peopleCountTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            peopleCountTextField.heightAnchor.constraint(equalToConstant: 50),

            phoneNumberTextField.topAnchor.constraint(equalTo: peopleCountTextField.bottomAnchor, constant: 15),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),

            addReservationButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addReservationButton.heightAnchor.constraint(equalToConstant: 40),
            addReservationButton.widthAnchor.constraint(equalToConstant: 240),
            addReservationButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func isValidRussianPhoneNumber(_ number: String) -> Bool {
        let phoneRegex = "^((\\+7|7|8)+([0-9]){10})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: number)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    private func validate() -> Bool {
        var isValid = true

        if let name = nameTextField.text, !name.isEmpty {
            nameTextField.applyNormalStyle()
        } else {
            nameTextField.applyErrorStyle()
            isValid = false
        }

        if let email = emailTextField.text, isValidEmail(email) {
            emailTextField.applyNormalStyle()
        } else {
            emailTextField.applyErrorStyle()
            isValid = false
        }

        if let phoneNumber = phoneNumberTextField.text, isValidRussianPhoneNumber(phoneNumber) {
            phoneNumberTextField.applyNormalStyle()
        } else {
            phoneNumberTextField.applyErrorStyle()
            isValid = false
        }

        if let peopleCount = peopleCountTextField.text, !peopleCount.isEmpty, Int(peopleCount) != nil {
            peopleCountTextField.applyNormalStyle()
        } else {
            peopleCountTextField.applyErrorStyle()
            isValid = false
        }

        if let dateString = dateTextField.text, !dateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "d MMM yyyy 'в' HH:mm"
            dateFormatter.timeZone = TimeZone.current
            if dateFormatter.date(from: dateString) != nil {
                dateTextField.applyNormalStyle()
            } else {
                dateTextField.applyErrorStyle()
                isValid = false
            }
        } else {
            dateTextField.applyErrorStyle()
            isValid = false
        }

        return isValid
    }

}
