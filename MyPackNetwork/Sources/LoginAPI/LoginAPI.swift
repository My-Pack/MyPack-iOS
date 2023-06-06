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

public struct LoginResponse: Codable {
    public var accessToken: String
    public var refreshToken: String
}

public class LoginAPI {
    public init() {}

    public func fetchData(token: String) async throws -> LoginResponse {
        let loginRequest = LoginRequest(credential: token, clientId: APIClient.shared.clientId)
        let parameters = APIClient.shared.convertToDictionary(loginRequest)

        do {
            let data = try await APIClient.shared.post(endPoint: "/auth/google", parameters: parameters)
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            return loginResponse
        } catch {
            throw error
        }
    }
}
