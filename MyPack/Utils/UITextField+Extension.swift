//
//  UITextField+Extension.swift
//  MyPack
//
//  Created by jito on 2023/05/23.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }

    func addRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        let image = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        image.tintColor = .black
        paddingView.addSubview(image)
        image.snp.makeConstraints { image in
            image.width.equalTo(20)
            image.height.equalTo(20)
            image.trailing.equalTo(-10)
            image.centerY.equalTo(paddingView)
        }
        rightView = paddingView
        rightViewMode = ViewMode.always
    }

    func setPlaceholder(color: UIColor) {
        guard let string = placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
