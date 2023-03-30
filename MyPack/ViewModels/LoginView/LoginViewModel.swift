//
//  LoginViewModel.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation

protocol LogvinViewModelProvider {
    func login()
}

class LoginViewModel: LogvinViewModelProvider {
    var loginCoordinator: LoginCoordinator?

    init(loginCoordinator: LoginCoordinator? = nil) {
        self.loginCoordinator = loginCoordinator
    }

    func login() {
        let userData = UserModel(name: "jito")
        loginCoordinator?.showMain(user: userData)
    }
}
