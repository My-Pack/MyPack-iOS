//
//  ThirdViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController {
    private let viewModel: ThirdViewModel

    init(viewModel: ThirdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰 로드 시 필요한 초기화 작업 수행
    }

    // 뷰가 나타날 때마다 호출되는 메서드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 뷰가 나타날 때마다 필요한 작업 수행
    }

    // 뷰가 사라질 때마다 호출되는 메서드
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 뷰가 사라질 때마다 필요한 작업 수행
    }
}
