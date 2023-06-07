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
}

// MARK: - 생성자

class Card: UIView {
    weak var delegate: CardDelegate?
    var effect: [CardEffect]?
    var image: UIImage?
    var imageView: UIImageView!
    var backView: UIView = .init()
    private var color: UIColor?
    private let cardAnimator: CardAnimator = .init()
    private var startLocation: CGPoint = .zero
    private var startRotate: CGPoint = .zero
    private var disappearPoint = CGPoint(x: 60, y: UIScreen.main.bounds.height - 60)
    private var flipFirstPoint = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: UIScreen.main.bounds.height / 2)
    private var flipSecondPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    private var icon: UIImageView!

    init(isInteraction: Bool = true, color: UIColor = .white, effect: [CardEffect] = [CardEffect(image: "none")], image: UIImage) {
        self.image = image
        self.color = color
        self.effect = effect
        self.imageView = UIImageView(image: image)
        self.icon = UIImageView(image: UIImage(named: effect.first!.image))
        super.init(frame: CGRect.zero)

        self.backgroundColor = color
        layer.borderWidth = 3
        layer.borderColor = color.cgColor

        layer.cornerRadius = 10
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.35
        self.isUserInteractionEnabled = isInteraction

        setUI()
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

// MARK: - ui setting

extension Card {
    func setUI() {
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.isUserInteractionEnabled = true
        let backFlip = UITapGestureRecognizer(target: self, action: #selector(backFlipView))
        imageView.addGestureRecognizer(backFlip)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }

        addSubview(backView)
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 16
        backView.isUserInteractionEnabled = true
        backView.backgroundColor = .white
        let frontFlip = UITapGestureRecognizer(target: self, action: #selector(frontFlipView))
        backView.addGestureRecognizer(frontFlip)
        backView.isHidden = true
        backView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

// MARK: - override

extension Card {
    @objc func backFlipView() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.snp.updateConstraints { make in
                    make.width.equalTo(300)
                    make.height.equalTo(400)
                }
                self.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                UIView.transition(from: self.imageView, to: self.backView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            }
        }, completion: nil)
    }

    @objc func frontFlipView() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.snp.updateConstraints { make in
                    make.width.equalTo(200)
                    make.height.equalTo(300)
                }
                self.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                UIView.transition(from: self.backView, to: self.imageView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            }
        }, completion: nil)
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
