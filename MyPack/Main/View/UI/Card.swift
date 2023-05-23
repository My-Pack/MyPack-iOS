//
//  Card.swift
//  MyPack
//
//  Created by jito on 2023/04/06.
//

import Foundation
import MyPackAnimation
import UIKit

///
/// 애니메이션 관련된 코드는 모두 모듈화 하기
///
///
protocol CardDelegate: AnyObject {
    func cardDidFlip(_ card: Card)
    func cardDidDisappear(_ card: Card)
}

struct CardEffect {
    var image: String
    var color: UIColor
}

// MARK: - 생성자

class Card: UIView {
    weak var delegate: CardDelegate?
    var effect: [CardEffect]?
    private var color: UIColor?
    private let cardAnimator: CardAnimator = .init()
    private var startLocation: CGPoint = .zero
    private var startRotate: CGPoint = .zero
    private var disappearPoint = CGPoint(x: 60, y: UIScreen.main.bounds.height - 60)
    private var flipFirstPoint = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: UIScreen.main.bounds.height / 2)
    private var flipSecondPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    private var icon: UIImageView!

    init(isInteraction: Bool = true, color: UIColor = .clear, effect: [CardEffect] = [CardEffect(image: "none", color: UIColor.gray)]) {
        super.init(frame: CGRect.zero)
        self.color = color
        self.backgroundColor = color
        self.effect = effect

        layer.borderWidth = 3
        layer.borderColor = effect.first!.color.cgColor

        layer.cornerRadius = 10
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.35

        self.icon = UIImageView(image: UIImage(named: effect.first!.image))

        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        self.isUserInteractionEnabled = isInteraction
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

// MARK: - override

extension Card {
    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        if let touch = touches.first {
            startLocation = touch.location(in: superview)
            startRotate = touch.location(in: superview)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        if let touch = touches.first, let superview = superview {
            let currentLocation = touch.location(in: superview)
            let targetCenter = CGPoint(x: center.x + (currentLocation.x - startLocation.x),
                                       y: center.y + (currentLocation.y - startLocation.y))

            let directionX = currentLocation.x - startRotate.x
            let directionY = currentLocation.y - startRotate.y

            let tiltAngle: CGFloat = 3
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 500
            transform = CATransform3DRotate(transform, -tiltAngle * directionY / superview.bounds.height, 1, 0, 0)
            transform = CATransform3DRotate(transform, tiltAngle * directionX / superview.bounds.width, 0, 1, 0)

            UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: { [self] in
                center = targetCenter
            }, completion: nil)

            UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
                self.layer.transform = transform
            }, completion: { _ in
                self.startRotate = currentLocation
            })
            startLocation = currentLocation
        }
    }

    override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        checkAnimation()
    }

    override func touchesCancelled(_: Set<UITouch>, with _: UIEvent?) {
        checkAnimation()
    }
}

// MARK: - functions

extension Card {
    private func checkAnimation() {
        switch cardAnimator.isTargetPosition(view: self) {
        case .disappear:
            cardAnimator.disappearAtPoint(view: self, point: disappearPoint, duration: 0.35) { [self] in
                delegate?.cardDidDisappear(self)
            }
        case .flip:
            cardAnimator.flipAtPoint(view: self, firstPoint: flipFirstPoint, secondPoint: flipSecondPoint, duration: 0.2) { [self] in
                delegate?.cardDidFlip(self)
            }
        case nil:
            moveToCenter()
        }
    }

    private func moveToCenter() {
        if let superview = superview {
            cardAnimator.moveToCenter(view: self, superview: superview, duration: 0.5)
        }
    }
}
