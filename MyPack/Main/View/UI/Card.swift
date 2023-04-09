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
}

// MARK: - 생성자

class Card: UIView {
    weak var delegate: CardDelegate?
    private let cardAnimator: CardAnimator = .init()
    private var startLocation: CGPoint = .zero
    private var startRotate: CGPoint = .zero
    private let gradientLayer = CAGradientLayer()
    private var disappearPoint = CGPoint(x: 60, y: UIScreen.main.bounds.height - 60)
    private var flipFirstPoint = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: UIScreen.main.bounds.height / 2)
    private var flipSecondPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)

    init(isInteraction: Bool = true, color: UIColor = .clear) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = color
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.35
        // setupGradientLayer()

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
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

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
    func animateGradient() {
        let gradient1: [CGColor] = [UIColor.green.cgColor, UIColor.yellow.cgColor]
        let gradient2: [CGColor] = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        let gradient3: [CGColor] = [UIColor.orange.cgColor, UIColor.cyan.cgColor]
        let gradient4: [CGColor] = [UIColor.cyan.cgColor, UIColor.green.cgColor]

        let gradientColors: [[CGColor]] = [gradient1, gradient2, gradient3, gradient4, gradient1]
        let keyTimes: [NSNumber] = [0, 0.25, 0.5, 0.75, 1]

        let animation = CAKeyframeAnimation(keyPath: "colors")
        animation.values = gradientColors
        animation.keyTimes = keyTimes
        animation.duration = 8.0 // 애니메이션 지속 시간
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.repeatCount = .infinity // 무한 반복

        gradientLayer.add(animation, forKey: "animateGradient")
    }

    func checkAnimation() {
        switch cardAnimator.isTargetPosition(view: self) {
        case .disappear:
            cardAnimator.disappearAtPoint(view: self, point: disappearPoint, duration: 0.35)
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

    private func setupGradientLayer() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)

        animateGradient()
    }
}
