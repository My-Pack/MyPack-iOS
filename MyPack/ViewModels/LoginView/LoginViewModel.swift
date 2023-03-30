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

    var loggedInListener: ((UserModel) -> Void)?

    init(loginCoordinator: LoginCoordinator? = nil) {
        self.loginCoordinator = loginCoordinator

        self.loggedInListener = { userData in
            loginCoordinator?.showMain(user: userData)
        }
        EventManager.shared.addObserver(for: "loggedIn", listener: loggedInListener!)
    }

    func login() {
        // 비동기 api 호출
        let user = UserModel(name: "jito")
        // 이벤트 발행
        EventManager.shared.post(event: "loggedIn", data: user)
    }
}
