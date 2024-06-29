//
//  AddReviewView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit

class AddReviewView: UIView {

    lazy var userNameTextField: UITextField = {
        getTextField(with: "Имя пользователя")
    }()

    lazy var reviewTitleTextField: UITextField = {
        getTextField(with: "Заголовок отзыва")
    }()

    lazy var reviewBodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor(red: 40/255, green: 42/255, blue: 60/255, alpha: 1.0).cgColor
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()

    private var ratingPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        return picker
    }()

    lazy var reviewRatingTextField: UITextField = {
        let textField = getTextField(with: "Оценка")
        textField.inputView = ratingPickerView
        return textField
    }()

    lazy var submitReviewButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.setTitle("Оставить отзыв", for: .normal)

        let action = UIAction { [weak self] _ in
            self?.submitReview()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var submitReviewButtonAction: ((Review) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        configurePickerView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddReviewView: UIPickerViewDataSource, UIPickerViewDelegate {

    private func submitReview() {
        guard let name = userNameTextField.text, !name.isEmpty,
              let title = reviewTitleTextField.text, !title.isEmpty,
              let body = reviewBodyTextView.text, !body.isEmpty,
              let ratingText = reviewRatingTextField.text, !ratingText.isEmpty,
              let rating = Int(ratingText) else {
            print("Validation failed: One of the fields is empty or invalid")
            return
        }

        let review = Review(id: 0, name: name, title: title, body: body, rating: rating)
        submitReviewButtonAction?(review)
    }

    func setupLayout() {

        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(userNameTextField)
        addSubview(reviewTitleTextField)
        addSubview(reviewBodyTextView)
        addSubview(reviewRatingTextField)
        addSubview(submitReviewButton)

        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),

            reviewTitleTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 10),
            reviewTitleTextField.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            reviewTitleTextField.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            reviewTitleTextField.heightAnchor.constraint(equalToConstant: 50),

            reviewBodyTextView.topAnchor.constraint(equalTo: reviewTitleTextField.bottomAnchor, constant: 10),
            reviewBodyTextView.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            reviewBodyTextView.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            reviewBodyTextView.heightAnchor.constraint(equalToConstant: 250),

            reviewRatingTextField.topAnchor.constraint(equalTo: reviewBodyTextView.bottomAnchor, constant: 10),
            reviewRatingTextField.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            reviewRatingTextField.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            reviewRatingTextField.heightAnchor.constraint(equalToConstant: 50),

            submitReviewButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            submitReviewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            submitReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            submitReviewButton.heightAnchor.constraint(equalToConstant: 46)
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

    private func configurePickerView() {
        ratingPickerView.delegate = self
        ratingPickerView.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reviewRatingTextField.text = String(row + 1)
    }
}
