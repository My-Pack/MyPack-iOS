//
//  MainCoordinator.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import UIKit

class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = LoginViewModel(loginCoordinator: self)
        let loginViewController = LoginViewController(loginViewModel: viewModel)
        navigationController?.pushViewController(loginViewController, animated: false)
    }

    func showMain(user: UserModel) {
        let viewModel = MainTabBarViewModel()
        viewModel.user = user
        let mainTabBarViewController = MainTabBarViewController(viewModel: viewModel)
        navigationController?.pushViewController(mainTabBarViewController, animated: true)
    }
}
