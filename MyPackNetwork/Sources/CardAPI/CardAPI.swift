//
//  CardAPI.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/06.
//

import Foundation

public struct CardRequest: Codable {
    public init(title: String, content: String, imageId: Int, color: String, theme: String) {
        self.title = title
        self.content = content
        self.imageId = imageId
        self.color = color
        self.theme = theme
    }

    var title: String
    var content: String
    var imageId: Int
    var color: String
    var theme: String
}

struct CardResponse: Codable {
    var id: Int
    var title: String
    var content: String
    var imageUrl: String
    var color: String
    var theme: String
    var likeCount: Int
    var commentCount: Int
    var memberName: String
    var createdAt: String
    var updatedAt: String

    func toDto() -> CardDto {
        return CardDto(
            id: id,
            title: title,
            content: content,
            imageUrl: imageUrl,
            color: color,
            theme: theme,
            likeCount: likeCount,
            commentCount: commentCount,
            memberName: memberName,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

public class CardAPI {
    public init() {}

    public func uploadData(token: String, request: CardRequest) async throws -> CardDto {
        let parameters = APIClient.shared.convertToDictionary(request)
        do {
            let data = try await APIClient.shared.post(endPoint: "/cards", parameters: parameters, token: token)
            let cardResponse = try JSONDecoder().decode(CardResponse.self, from: data)
            print(cardResponse)
            return cardResponse.toDto()
        } catch {
            throw error
        }
    }

    public func fetchData(token: String) async throws -> UserDto {
        let loginRequest = LoginRequest(credential: token, clientId: APIClient.shared.clientId)
        let parameters = APIClient.shared.convertToDictionary(loginRequest)

        do {
            let data = try await APIClient.shared.post(endPoint: "/auth/google", parameters: parameters)
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            let userDto = UserDto(name: "jito")
            return userDto
        } catch {
            throw error
        }
    }
}
