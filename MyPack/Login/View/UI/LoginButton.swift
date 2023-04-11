//
//  LoginButton.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import UIKit

class LoginButton: UIButton {
    init(title: String, frame: CGRect, action: UIAction?) {
        super.init(frame: frame)
        setTitle(title, for: .normal)
        self.backgroundColor = .clear

        if let action {
            addAction(action, for: .touchUpInside)
        }
    }

    func setImage(_ image: UIImage, for state: UIControl.State) {
        setImage(image, for: state)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
