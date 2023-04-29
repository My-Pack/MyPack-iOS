//
//  APIClient.swift
//  MyPackNetwork
//
//  Created by jito on 2023/04/01.
//

import Foundation
import GoogleSignIn

public class APIClient {
    private init() {}
    static let shared = APIClient()

    private let baseURL = "https://mypack-dev.duckdns.org/api/v1"
    let clientId = "359063232439-c70rvi9jpapuurtmohl8ila077omosk9.apps.googleusercontent.com"

    private func request(endPoint: String, method: String, parameters: [String: Any]?) async throws -> Data {
        let urlString = baseURL + endPoint
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let parameters = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        if let httpResponse = response as? HTTPURLResponse, (200 ..< 300).contains(httpResponse.statusCode) {
            return data
        } else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
        }
    }

    func convertToDictionary<T: Encodable>(_ value: T) -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(value)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return jsonObject
        } catch {
            print("Error converting struct to dictionary: \(error.localizedDescription)")
            return nil
        }
    }

    func get(endPoint: String, parameters: [String: Any]? = nil) async throws -> Data {
        return try await request(endPoint: endPoint, method: "GET", parameters: parameters)
    }

    func post(endPoint: String, parameters: [String: Any]? = nil) async throws -> Data {
        return try await request(endPoint: endPoint, method: "POST", parameters: parameters)
    }
}
