//
//  LoginServiceImpl.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import Foundation
import MyPackNetwork

class LoginServiceImpl: LoginServiceProtocol {
    let api = APIClient()

    func login() async throws -> UserModel? {
        do {
            let data = try await api.fetchData()
            return data.toUserModel()
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}

extension UserDto {
    func toUserModel() -> UserModel {
        return UserModel(name: name)
    }
}
