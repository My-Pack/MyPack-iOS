//
//  CardAnimator.swift
//  MyPackAnimation
//
//  Created by jito on 2023/04/06.
//

import UIKit

public class CardAnimator {
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

    public func isTargetPosition(view: UIView, position: CGPoint) -> Bool {
        if view.center.x < position.x && view.center.y > position.y {
            return true
        }
        return false
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
}
