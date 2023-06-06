//
//  StyleButton.swift
//  MyPack
//
//  Created by jito on 2023/05/29.
//

import UIKit

class StyleButton: UIButton {
    init(color: UIColor, viewModel: SecondViewModel) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = color
        addAction(UIAction { _ in
            viewModel.setCardStyle(color: color)
        }, for: .touchUpInside)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 23
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
