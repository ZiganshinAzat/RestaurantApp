//
//  LoginViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    private let loginView = LoginView()
    private let loginViewModel: LoginViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = loginView
        loginView.loginButtonAction = loginUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
        setupBindings()
    }
}

extension LoginViewController {

    func setupBindings() {
        loginViewModel.$user
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

    func loginUser(user: User) {
        Task {
            do {
                try await loginViewModel.loginUser(user: user)
            } catch {
                DispatchQueue.main.async {
                    self.showLoginFailedAlert()
                }
            }
        }
    }

    func showLoginFailedAlert() {
        let alert = UIAlertController(title: "Ошибка входа", message: "Неверный email или пароль. Пожалуйста, попробуйте ещё раз.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))

        present(alert, animated: true, completion: nil)
    }
}
