//
//  SearchBtn.swift
//  MyPack
//
//  Created by jito on 2023/05/23.
//

import UIKit
class SearchBtn: UIButton {
    init(viewModel: FirstViewModel) {
        super.init(frame: .zero)
        addAction(UIAction(handler: { _ in
            viewModel.toSearch()
        }), for: .touchUpInside)
        setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        tintColor = UIColor.white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
