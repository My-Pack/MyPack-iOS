//
//  LoginCoordinator.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import UIKit

class LoginCoordinatorImpl: LoginCoordinator {
    let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let loginService = LoginServiceImpl()
        let viewModel = LoginViewModel(loginService: loginService, loginCoordinator: self)
        let loginViewController = LoginViewController(loginViewModel: viewModel)
        navigationController?.pushViewController(loginViewController, animated: false)
    }

    @MainActor
    func didLoginSuccessfully(userName: String) {
        let mainTabBarCoordinator = MainTabBarCoordinatorImpl(navigationController: navigationController)
        mainTabBarCoordinator.start(userName: userName)
    }
}
