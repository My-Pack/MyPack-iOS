//
//  LoginAPI.swift
//  MyPackNetwork
//
//  Created by jito on 2023/04/23.
//

import Foundation

struct LoginRequest: Codable {
    var credential: String
    var clientId: String
}

struct LoginResponse: Codable {
    var accessToken: String
    var refreshToken: String
}

public class LoginAPI {
    public init() {}

    public func fetchData(token: String) async throws -> UserDto {
        let loginRequest = LoginRequest(credential: token, clientId: APIClient.shared.clientId)
        let parameters = APIClient.shared.convertToDictionary(loginRequest)

        do {
            let data = try await APIClient.shared.post(endPoint: "/auth/google", parameters: parameters)
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            print("User Response:", loginResponse)
            let userDto = UserDto(name: "jito")
            return userDto
        } catch {
            throw error
        }
    }
}
