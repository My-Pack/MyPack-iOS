//
//  LoginViewModel.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation

class LoginViewModel {
    private let loginService: LoginServiceProtocol
    weak var loginCoordinator: LoginCoordinatorProtocol?

    init(loginService: LoginServiceProtocol, loginCoordinator: LoginCoordinatorImpl) {
        self.loginCoordinator = loginCoordinator
        self.loginService = loginService
    }

    func login() {
        loginService.login { [self] result in
            switch result {
            case let .success(data):
                print("Data fetched: \(data)")
                loginCoordinator?.didLoginSuccessfully(userModel: data)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
