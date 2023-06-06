//
//  LoginServiceImpl.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import Foundation
import MyPackNetwork

class LoginServiceImpl: LoginService {
    let api = LoginAPI()

    func login(token: String) async throws -> LoginResponse? {
        try await api.fetchData(token: token)
    }
}

extension UserDto {
    func toUserModel() -> UserModel {
        return UserModel(name: name)
    }
}
