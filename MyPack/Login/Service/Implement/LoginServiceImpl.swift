//
//  LoginServiceImpl.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import Foundation
import MyPackNetwork

class LoginServiceImpl: LoginServiceProtocol {
    let api = LoginAPI()

    func login(token: String) async throws -> UserModel? {
        try await api.fetchData(token: token).toUserModel()
    }
}

extension UserDto {
    func toUserModel() -> UserModel {
        return UserModel(name: name)
    }
}
