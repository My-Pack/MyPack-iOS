//
//  CardAnimator.swift
//  MyPackAnimation
//
//  Created by jito on 2023/04/06.
//

import UIKit

public enum AnimationType {
    case disappear
    case flip
}

public class CardAnimator {
    private var disappearRange = CGRect(x: -60, y: UIScreen.main.bounds.height, width: 100, height: 100)
    private var flipRange = CGRect(x: 330, y: UIScreen.main.bounds.height / 2 - 50, width: 200, height: 100)

    public init() {}

    public func moveToCenter(view: UIView, superview: UIView, duration: TimeInterval) {
        let centerX = superview.bounds.midX
        let centerY = superview.bounds.midY
        let centerPosition = CGPoint(x: centerX, y: centerY)

        UIView.animate(withDuration: duration, animations: {
            view.center = centerPosition
            view.layer.transform = CATransform3DIdentity
        })
    }

    public func isTargetPosition(view: UIView) -> AnimationType? {
        if disappearRange.contains(view.center) {
            return .disappear
        }
        if flipRange.contains(view.center) {
            return .flip
        }
        return nil
    }

    public func disappearAtPoint(view: UIView, point: CGPoint, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            view.center = point
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                view.alpha = 0
            }, completion: { _ in
                view.removeFromSuperview()
            })
        })
    }

    public func flipAtPoint(view: UIView, firstPoint: CGPoint, secondPoint: CGPoint, duration: TimeInterval, closure: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            view.center = firstPoint
        }, completion: { _ in
            closure()
            UIView.animate(withDuration: 0.2, animations: {
                view.center = secondPoint
                view.transform = CGAffineTransform.identity
            })
        })
    }
}
