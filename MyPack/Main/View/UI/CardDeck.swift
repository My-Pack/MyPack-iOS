//
//  CardDeck.swift
//  MyPack
//
//  Created by jito on 2023/04/06.
//

import Foundation
import UIKit

class CardDeck: UIView {
    var cardDeck: [Card] = [
        Card(isInteraction: false, color: .white),
        Card(isInteraction: false, color: .white, effect: [CardEffect(image: "heart", color: UIColor(rgb: 0xF699CD))]),
        Card(isInteraction: true, color: .white, effect: [CardEffect(image: "star_gold", color: UIColor(rgb: 0xE5B80B)),
                                                          CardEffect(image: "heart_gold", color: UIColor(rgb: 0xE5B80B))])
    ]

    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
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
        cardDeck.last?.layer.zPosition = 1000
        for i in cardDeck {
            i.delegate = self
            addSubview(i)
            i.snp.makeConstraints { deck in
                deck.width.equalTo(200)
                deck.height.equalTo(300)
                deck.centerX.equalTo(self)
                deck.centerY.equalTo(self)
            }
        }
    }
}

// MARK: - CardDelegate

extension CardDeck: CardDelegate {
    func cardDidFlip(_ card: Card) {
        card.layer.zPosition = 0
        card.isUserInteractionEnabled = false
        cardDeck[1].isUserInteractionEnabled = true
        cardDeck[1].layer.zPosition = 1000
        cardDeck.swapAt(1, 2)
    }

    func cardDidDisappear(_: Card) {
        cardDeck.remove(at: cardDeck.firstIndex(where: { $0.isUserInteractionEnabled })!)
        cardDeck.last?.isUserInteractionEnabled = true
        cardDeck.last?.layer.zPosition = 1000

        let nextCard = Card(isInteraction: false, color: UIColor.white)
        addSubview(nextCard)

        nextCard.delegate = self
        nextCard.layer.zPosition = 0
        cardDeck.insert(nextCard, at: 1)
        nextCard.snp.makeConstraints { card in
            card.width.equalTo(200)
            card.height.equalTo(300)
            card.centerX.equalTo(self)
            card.centerY.equalTo(self)
        }
    }
}
