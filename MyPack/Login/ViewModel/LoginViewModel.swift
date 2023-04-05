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

    private func fetchUserName() async -> String? {
        do {
            let userModel = try await loginService.login()
            return userModel?.name
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    func login() {
        Task {
            if let userName = await fetchUserName() {
                await loginCoordinator?.didLoginSuccessfully(userName: userName)
            }
        }
    }
}
