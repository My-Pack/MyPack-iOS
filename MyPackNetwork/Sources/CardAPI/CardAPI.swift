//
//  CardAPI.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/06.
//

import Foundation

public class CardAPI {
    public init() {}

    public func uploadData(token: String, request: CardRequest) async throws -> CardDto {
        let parameters = APIClient.shared.convertToDictionary(request)
        do {
            let data = try await APIClient.shared.post(endPoint: "/cards", parameters: parameters, token: token)
            let cardResponse = try JSONDecoder().decode(CardResponse.self, from: data)
            return cardResponse.toDto()
        } catch {
            throw error
        }
    }

    public func getCardList(token _: String) async throws -> CardListDto {
        do {
            let data = try await APIClient.shared.get(endPoint: "/cards")
            let cardListResponse = try JSONDecoder().decode(CardListResponse.self, from: data)
            return cardListResponse.toDto()
        }
    }
}
