//
//  SecondViewModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import UIKit

class SecondViewModel {
    let title: String
    let message: String
    @Published var pickedImage: UIImage?
    @Published var isPicked: Bool = false
    @Published var cardStyle: UIColor = .white

    init() {
        self.title = "Second"
        self.message = "This is the second tab."
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
}
