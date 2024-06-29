//
//  ManagerAuthenticationViewViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit
import Combine

class ManagerAuthenticationViewController: UIViewController {

    private let managerAuthView = ManagerAuthenticationView()
    private let managerAuthViewModel: ManagerAuthenticationViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(managerAuthViewModel: ManagerAuthenticationViewModel) {
        self.managerAuthViewModel = managerAuthViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = managerAuthView
        managerAuthView.loginButtonAction = loginButtonAction
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
        setupBindings()
    }
}

extension ManagerAuthenticationViewController {

    func loginButtonAction() {
        Task {
            do {
                let user = User(id: 0, email: "", password: managerAuthView.passwordTextField.text!, isAdmin: true)
                try await managerAuthViewModel.loginUser(user: user)
                print(777)
            } catch {
                DispatchQueue.main.async {
                    self.showLoginFailedAlert()
                }
            }
        }
    }

    func setupBindings() {
        managerAuthViewModel.$user
            .dropFirst()
            .sink { [weak self] user in
                guard let self else { return }
                if let userId = user?.id {
                    UserDefaultsManager.saveUserId(userId)
                    UserDefaultsManager.saveIsAdmin(true)
                }
                DispatchQueue.main.async {
                    let adminViewModel = AdminViewModel(restaurantAPIManager: FoodiesAPIManager())
                    self.navigationController?.pushViewController(AdminViewController(adminViewModel: adminViewModel), animated: true)
                }
            }
            .store(in: &cancellables)
    }

    func showLoginFailedAlert() {
        let alert = UIAlertController(title: "Ошибка входа", message: "Неверный пароль", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))

        present(alert, animated: true, completion: nil)
    }
}
