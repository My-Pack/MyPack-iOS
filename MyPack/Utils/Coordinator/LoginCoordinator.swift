//
//  MainCoordinator.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import UIKit

protocol LoginCoordinator: Coordinator {
    func didLoginSuccessfully(userModel: UserModel)
    func didFailLogin(withError error: Error)
}

class LoginCoordinatorImpl: LoginCoordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = LoginViewModel(loginCoordinator: self)
        let loginViewController = LoginViewController(loginViewModel: viewModel)
        navigationController?.pushViewController(loginViewController, animated: false)
    }

    func didLoginSuccessfully(userModel: UserModel) {
        let viewModel = MainTabBarViewModel()
        viewModel.user = userModel
        let mainTabBarViewController = MainTabBarViewController(viewModel: viewModel)
        navigationController?.pushViewController(mainTabBarViewController, animated: true)
    }

    func didFailLogin(withError error: Error) {
        print("Login failed with error: \(error)")
    }
}
