//
//  CardDeck.swift
//  MyPack
//
//  Created by jito on 2023/04/06.
//

import Foundation
import UIKit

class CardDeck: UIView {
    var cardDeck: [Card] = []

    init(cardDeck: [Card] = []) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true

        if cardDeck.count > 0 {
            self.cardDeck = cardDeck
        }
        setPosition()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Functions

extension CardDeck {
    func setPosition() {
//        let rotationAngle = CGFloat(-5 * Double.pi / 180.0)
//        cardDeck.first?.transform = CGAffineTransform(rotationAngle: rotationAngle)
        for (index, i) in cardDeck.enumerated() {
            i.delegate = self
            i.layer.zPosition = CGFloat(index * 100)
            i.layer.shadowOpacity = 0
            addSubview(i)
            i.snp.makeConstraints { deck in
                deck.width.equalTo(200)
                deck.height.equalTo(300)
                deck.centerX.equalTo(self)
                deck.centerY.equalTo(self)
            }
        }
        cardDeck.last?.layer.shadowOpacity = 1
    }

    func setPositionZ() {
        for (index, i) in cardDeck.enumerated() {
            i.layer.zPosition = CGFloat(index * 100)
            i.layer.shadowOpacity = 0
        }
    }
}

// MARK: - CardDelegate

extension CardDeck: CardDelegate {
    func cardDidFlip(_ card: Card) {
        card.layer.zPosition = 0
        card.isUserInteractionEnabled = false
        card.layer.shadowOpacity = 0

        let flipCard = cardDeck.popLast()!
        cardDeck.insert(flipCard, at: 0)
        setPositionZ()

        cardDeck[cardDeck.count - 1].isUserInteractionEnabled = true
        cardDeck[cardDeck.count - 1].layer.shadowOpacity = 1
    }

    func cardDidDisappear(_: Card) {}
}
