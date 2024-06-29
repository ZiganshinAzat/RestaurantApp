//
//  RegistrationViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {

    private let registrationView = RegistrationView()
    private let registrationViewModel: RegistrationViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(registrationViewModel: RegistrationViewModel) {
        self.registrationViewModel = registrationViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = registrationView
        registrationView.registerButtonAction = registerButtonAction
        registrationView.showEmailAlert = showEmailAlert
        registrationView.showPasswordAlert = showPasswordAlert
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
        setupBindings()
    }
}

extension RegistrationViewController {

    func registerButtonAction(user: User) {
        Task {
            do {
                try await registrationViewModel.registerUser(user: user)
            } catch {
                DispatchQueue.main.async {
                    self.showEmailAlreadyExistsAlert()
                }
            }
        }
    }

    func setupBindings() {
        registrationViewModel.$user
            .dropFirst()
            .sink { [weak self] user in
                guard let self else { return }
                if let userId = user?.id {
                    UserDefaultsManager.saveUserId(userId)
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            .store(in: &cancellables)
    }

    func showEmailAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Некорректный адрес электронной почты", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))

        present(alert, animated: true, completion: nil)
    }

    func showPasswordAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Пароль должен содержать как минимум одну заглавную букву, цифру и спецсимвол", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))

        present(alert, animated: true, completion: nil)
    }

    func showEmailAlreadyExistsAlert() {
        let alert = UIAlertController(title: "Ошибка регистрации", message: "Пользователь с такой почтой уже существует", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))

        present(alert, animated: true, completion: nil)
    }
}
