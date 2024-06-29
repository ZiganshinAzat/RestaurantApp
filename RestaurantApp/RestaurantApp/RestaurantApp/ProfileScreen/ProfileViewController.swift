//
//  ProfileViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 03.05.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    private let regLogView = RegLogView()
    private let profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        configureViewForCurrentUser()
    }
}

extension ProfileViewController {

    func configureViewForCurrentUser() {
        if isUserLoggedIn() {
            userLoggedIn()
        } else {
            userNotLoggedIn()
        }
    }

    func isUserLoggedIn() -> Bool {

        return UserDefaultsManager.loadUserId() != 0
    }

    func userNotLoggedIn() {
        view = regLogView
        regLogView.logInButtonAction = logInButtonAction
        regLogView.signUpButtonAction = signUpButtonAction
        regLogView.managerButtonAction = managerButtonAction
    }

    func userLoggedIn() {
        view = profileView
    }

    func logInButtonAction() {
        let loginViewModel = LoginViewModel(restaurantAPIManager: FoodiesAPIManager())
        self.navigationController?.pushViewController(LoginViewController(loginViewModel: loginViewModel), animated: true)
    }

    func signUpButtonAction() {
        let registrationViewModel = RegistrationViewModel(restaurantAPIManager: FoodiesAPIManager())
        self.navigationController?.pushViewController(RegistrationViewController(registrationViewModel: registrationViewModel), animated: true)
    }

    func managerButtonAction() {
        let managerAuthViewModel = ManagerAuthenticationViewModel(restaurantAPIManager: FoodiesAPIManager())
        let managerAuthViewController = ManagerAuthenticationViewController(managerAuthViewModel: managerAuthViewModel)
        self.navigationController?.pushViewController(managerAuthViewController, animated: true)
    }
}
