//
//  FirstViewModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import MyPackAnimation
import MyPackNetwork
import UIKit

class FirstViewModel {
    var cardService: CardService
    var mainTabBarCoordinator: MainTabBarCoordinator
    let title: String
    let message: String

    @Published var userName: String = ""
    @Published var cardDeck: CardDeck = .init(cardDeck: [])

    init(userName: String, mainTabBarCoordinator: MainTabBarCoordinator, cardService: CardService) {
        self.title = "First"
        self.message = "This is the first tab."
        self.mainTabBarCoordinator = mainTabBarCoordinator
        self.cardService = cardService
        setUser(userName: userName)
    }

    func setUser(userName: String) {
        self.userName = userName
    }

    func toSearch() {
        mainTabBarCoordinator.toSearchView()
    }

    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "InvalidImage", code: -1, userInfo: nil)
        }
        return image
    }

    @MainActor
    func getCardList(token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let cardList = try await self.cardService.getCardList(token: token)
                try await setCardDeck(cardList: cardList)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    @MainActor
    func setCardDeck(cardList: CardListDto) async throws {
        for i in cardList.content {
            let url = URL(string: i.imageUrl)!
            do {
                let image = try await fetchImage(from: url)
                cardDeck.cardDeck.append(Card(isInteraction: false, color: UIColor(hexString: i.color), effect: [CardEffect(image: i.theme)], image: image, title: i.title, content: i.content))
            } catch {
                throw NSError(domain: "Cannot Append Card", code: -1, userInfo: nil)
            }
        }

        cardDeck.cardDeck.last?.isUserInteractionEnabled = true
        cardDeck.setPosition()
    }
}
