//
//  SecondViewModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import MyPackNetwork
import UIKit

class SecondViewModel {
    private let cardService: CardService = CardServiceImpl()
    var mainTabBarCoordinator: MainTabBarCoordinator?

    let title: String
    let message: String

    @Published var pickedImage: UIImage?
    @Published var isPicked: Bool = false
    @Published var cardStyle: UIColor = .white

    @Published var cardTitle: String = ""
    @Published var cardContent: String = ""
    @Published var cardColor: String = ""
    @Published var cardTheme: String = "normal"

    init(mainTabBarCoordinator: MainTabBarCoordinator) {
        self.title = "Second"
        self.message = "This is the second tab."
        self.mainTabBarCoordinator = mainTabBarCoordinator
    }

    func setPickedImage(img: UIImage) {
        pickedImage = img
    }

    func setIsPicked(bool: Bool) {
        isPicked = bool
    }

    func setCardStyle(color: UIColor) {
        cardStyle = color
    }

    func setCardTitle(text: String) {
        cardTitle = text
    }

    func setCardContent(text: String) {
        cardContent = text
    }

    func isValidCardData() -> Bool {
        print(cardTitle)
        print(cardContent)
        print(cardColor)
        print(cardTheme)
        guard cardTitle.count > 0 else { return false }
        guard cardContent.count > 0 else { return false }
        guard cardColor.count > 0 else { return false }
        guard cardTheme.count > 0 else { return false }

        return true
    }

    func uploadImage(token: String, image: UIImage, fileName: String) async throws -> Int {
        let imageData = image.jpegData(compressionQuality: 1.0)
        if let imageData = imageData {
            return try await cardService.uploadImage(token: token, image: imageData, fileName: fileName)
        }
        return -1
    }

    func uploadCard(token: String, imageId: Int) async throws -> CardDto {
        let cardRequest = CardRequest(
            title: cardTitle,
            content: cardContent,
            imageId: imageId,
            color: cardColor,
            theme: cardTheme
        )
        return try await cardService.uploadCard(token: token, cardRequest: cardRequest)
    }
}
