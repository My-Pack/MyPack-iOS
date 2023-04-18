//
//  APIClient.swift
//  MyPackNetwork
//
//  Created by jito on 2023/04/01.
//

import Foundation
import GoogleSignIn

public class APIClient {
    public init() {}

    public func fetchData() async throws -> UserDto {
//        guard let url = URL(string: "https://api.example.com/data") else {
//            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
//        }
//
//        let (_, response) = try await URLSession.shared.data(from: url)
//        guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
//            throw NSError(domain: "Bad response", code: -1, userInfo: nil)
//        }
        return UserDto(name: "jito")
    }
}
