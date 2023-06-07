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
        let rotationAngle = CGFloat(-5 * Double.pi / 180.0)
        cardDeck.first?.transform = CGAffineTransform(rotationAngle: rotationAngle)
        for (index, i) in cardDeck.enumerated() {
            i.delegate = self
            i.layer.zPosition = CGFloat(index * 100)
            addSubview(i)
            i.snp.makeConstraints { deck in
                deck.width.equalTo(200)
                deck.height.equalTo(300)
                deck.centerX.equalTo(self)
                deck.centerY.equalTo(self)
            }
        }
    }

    func setPositionZ() {
        for (index, i) in cardDeck.enumerated() {
            i.layer.zPosition = CGFloat(index * 100)
        }
    }
}

// MARK: - CardDelegate

extension CardDeck: CardDelegate {
    func cardDidFlip(_ card: Card) {
        print(cardDeck.map { $0.image })
        print(cardDeck.map { $0.layer.zPosition })
        print(cardDeck.map { $0.isUserInteractionEnabled })
        card.layer.zPosition = 0
        card.isUserInteractionEnabled = false
        cardDeck[cardDeck.count - 2].isUserInteractionEnabled = true
        let flipCard = cardDeck.popLast()!
        cardDeck.insert(flipCard, at: 1)
        setPositionZ()
    }

    func cardDidDisappear(_: Card) {}
}
