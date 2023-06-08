//
//  LogoView.swift
//  MyPack
//
//  Created by 김하은 on 2023/04/11.
//

import UIKit

class ImageView: UIImageView {
    init(image: UIImage, frame: CGRect) {
        super.init(frame: frame)
        self.image = image
        self.contentMode = .scaleToFill
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
