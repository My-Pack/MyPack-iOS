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

// MARK: - 생성자

class Card: UIImageView {
    weak var delegate: CardDelegate?
    private var color: UIColor?
    private let cardAnimator: CardAnimator = .init()
    private var startLocation: CGPoint = .zero
    private var startRotate: CGPoint = .zero
    private var disappearPoint = CGPoint(x: 60, y: UIScreen.main.bounds.height - 60)
    private var flipFirstPoint = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: UIScreen.main.bounds.height / 2)
    private var flipSecondPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)

    private var gradientStartPosition: CGFloat = 0.0

    init(isInteraction: Bool = true, color: UIColor = .clear) {
        super.init(frame: CGRect.zero)
        self.color = color
        self.backgroundColor = color
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.35

        self.isUserInteractionEnabled = isInteraction

        image = applyRainbowHolographicEffect(to: UIImage(named: "newjeans")!)
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

    func applyRainbowHolographicEffect(to image: UIImage) -> UIImage? {
        guard let inputCGImage = image.cgImage else { return nil }

        let inputImage = CIImage(cgImage: inputCGImage)
        let context = CIContext(options: nil)

        // 무지개 그라데이션을 생성하는 두 개의 CIFilter를 만듭니다.
        let gradientFilter1 = createGradientFilter(startPoint: gradientStartPosition, endPoint: gradientStartPosition + inputImage.extent.width)
        let gradientFilter2 = createGradientFilter(startPoint: gradientStartPosition - inputImage.extent.width, endPoint: gradientStartPosition)

        // 두 개의 그라데이션 필터를 결합합니다.
        let combinedGradientFilter = CIFilter(name: "CIAdditionCompositing")
        combinedGradientFilter?.setValue(gradientFilter1?.outputImage, forKey: kCIInputImageKey)
        combinedGradientFilter?.setValue(gradientFilter2?.outputImage, forKey: kCIInputBackgroundImageKey)

        // 빛이 반사되는 원형 그라데이션을 생성하는 CIFilter를 만듭니다.
        let reflectionFilter = CIFilter(name: "CIRadialGradient")
        let reflectionCenter = CIVector(x: inputImage.extent.width / 2, y: inputImage.extent.height / 2)
        reflectionFilter?.setValue(reflectionCenter, forKey: "inputCenter")
        reflectionFilter?.setValue(0, forKey: "inputRadius0")
        reflectionFilter?.setValue(inputImage.extent.width / 2, forKey: "inputRadius1")
        reflectionFilter?.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 0.5), forKey: "inputColor0")
        reflectionFilter?.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 0), forKey: "inputColor1")

        // 무지개 그라데이션과 빛 반사 그라데이션을 결합합니다.
        let combinedRainbowAndReflectionFilter = CIFilter(name: "CIScreenBlendMode")
        combinedRainbowAndReflectionFilter?.setValue(combinedGradientFilter?.outputImage, forKey: kCIInputImageKey)
        combinedRainbowAndReflectionFilter?.setValue(reflectionFilter?.outputImage, forKey: kCIInputBackgroundImageKey)

        // 홀로그램 효과를 입히기 위해 결합된 그라데이션과 원본 이미지를 결합하는 CIFilter를 만듭니다.
        let blendFilter = CIFilter(name: "CIScreenBlendMode")
        blendFilter?.setValue(inputImage, forKey: kCIInputImageKey)
        blendFilter?.setValue(combinedRainbowAndReflectionFilter?.outputImage?.cropped(to: inputImage.extent), forKey: kCIInputBackgroundImageKey)

        if let outputImage = blendFilter?.outputImage,
           let cgImage = context.createCGImage(outputImage, from: inputImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return nil
    }

    func createGradientFilter(startPoint: CGFloat, endPoint: CGFloat) -> CIFilter? {
        let gradientFilter = CIFilter(name: "CILinearGradient")
        gradientFilter?.setValue(CIVector(x: startPoint, y: 0), forKey: "inputPoint0")
        gradientFilter?.setValue(CIVector(x: endPoint, y: 0), forKey: "inputPoint1")
        gradientFilter?.setValue(CIColor(red: 1, green: 0, blue: 0, alpha: 0.5), forKey: "inputColor0")
        gradientFilter?.setValue(CIColor(red: 0, green: 0, blue: 1, alpha: 0.5), forKey: "inputColor1")
        return gradientFilter
    }
}
