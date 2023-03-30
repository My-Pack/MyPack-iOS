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
    func login() {
        let userData = UserModel(name: "jito")
        EventManager.shared.post(event: "loggedIn", data: userData)
    }
}
