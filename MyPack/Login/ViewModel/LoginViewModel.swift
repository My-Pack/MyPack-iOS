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

    init(loginService: LoginServiceProtocol, loginCoordinator: LoginCoordinatorProtocol) {
        self.loginCoordinator = loginCoordinator
        self.loginService = loginService
    }

    private func fetchUserName(token: String) async -> String? {
        do {
            let userModel = try await loginService.login(token: token)
            return userModel?.name
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    func login(token: String) {
        Task {
            if let userName = await fetchUserName(token: token) {
                await loginCoordinator?.didLoginSuccessfully(userName: userName)
            }
        }
    }
}
