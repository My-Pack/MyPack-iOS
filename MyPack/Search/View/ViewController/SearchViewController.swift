//
//  SearchViewController.swift
//  MyPack
//
//  Created by jito on 2023/05/23.
//

import UIKit

// MARK: - 뷰컨트롤러 생성자

class SearchViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 뷰컨트롤러 라이프 사이클

extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - 뷰모델 관련

private extension SearchViewController {
    func setBindings() {}
}
