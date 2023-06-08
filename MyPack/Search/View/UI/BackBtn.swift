//
//  BackBtn.swift
//  MyPack
//
//  Created by jito on 2023/05/23.
//

import UIKit

class BackBtn: UIButton {
    init(viewModel: SearchViewModel) {
        super.init(frame: .zero)
        addAction(UIAction(handler: { _ in
            viewModel.toMain()
        }), for: .touchUpInside)
        setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        tintColor = UIColor.white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
