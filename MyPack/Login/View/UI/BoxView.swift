//
//  boxview.swift
//  MyPack
//
//  Created by 김하은 on 2023/04/11.
//

import UIKit

class BoxView: UIView {
    init(frame: CGRect, radius: CGFloat, color: UIColor) {
        super.init(frame: frame)
        layer.cornerRadius = radius
        self.backgroundColor = color
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
