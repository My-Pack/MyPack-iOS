//
//  CardServiceImpl.swift
//  MyPack
//
//  Created by jito on 2023/06/06.
//

import MyPackNetwork
import UIKit

class CardServiceImpl: CardService {
    let cardApi = CardAPI()
    let imageApi = ImageAPI()

    func uploadCard(token: String, cardRequest: CardRequest) async throws -> CardDto {
        return try await cardApi.uploadData(token: token, request: cardRequest)
    }

    func uploadImage(token _: String, image: Data, fileName: String) async throws -> Int {
        let imageData = try await imageApi.uploadImage(image: image, fileName: fileName)
        return imageData.id
    }

    func getCardList(token: String) async throws -> CardListDto {
        let cardList = try await cardApi.getCardList(token: token)
        return cardList
    }
}
