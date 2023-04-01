//
//  LoginViewModel.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation
import MyPackNetwork

class LoginViewModel {
    private let api = APIClient()
    weak var loginCoordinator: LoginCoordinator?

    init(loginCoordinator: LoginCoordinator? = nil) {
        self.loginCoordinator = loginCoordinator
    }

    func login() {
        // 비동기 api 호출
        api.fetchData { [self] result in
            switch result {
            case let .success(data):
                print("Data fetched: \(data)")
                loginCoordinator?.didLoginSuccessfully(userModel: UserModel(name: data))
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
