//
//  LoginServiceImpl.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import Foundation

class LoginServiceImpl: LoginServiceProtocol {
    func login(completion: @escaping (Result<UserModel, Error>) -> Void) {
        let user = UserModel(name: "Test User")
        completion(.success(user))
    }
}
