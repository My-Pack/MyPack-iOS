//
//  LogoLabel.swift
//  MyPack
//
//  Created by 김하은 on 2023/04/11.
//

import UIKit

class LogoLabel: UIView {
    private let label = UILabel()

    init(text: String, font: UIFont, textColor: UIColor, shadow: Bool) {
        super.init(frame: .zero)
        label.text = text
        label.font = font
        label.textColor = textColor

        if shadow {
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowOffset = CGSize(width: 4, height: 4)
            label.layer.shadowRadius = 2
            label.layer.shadowOpacity = 0.25
        }

        addSubview(label)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 66, y: 400, width: 265, height: 85)
    }
}
