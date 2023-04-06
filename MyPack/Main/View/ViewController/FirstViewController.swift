//
//  FirstViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import SnapKit
import UIKit

// MARK: - 뷰컨트롤러 생성자

class FirstViewController: UIViewController {
    private let viewModel: FirstViewModel
    private var disposableBag = Set<AnyCancellable>()
    private var card: Card = .init()

    init(viewModel: FirstViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = UIColor(rgb: 0x222222)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 뷰컨트롤러 라이프 사이클

extension FirstViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
        addUI()
        setLayout()
    }
}

// MARK: - 뷰모델 관련

private extension FirstViewController {
    func setBindings() {
        viewModel.$userName.sink { userName in
            print("user: \(userName)")
            self.updateUser(userName: userName)
        }.store(in: &disposableBag)
    }
}

// MARK: - UI 관련

private extension FirstViewController {
    func addUI() {
        view.addSubview(card)
    }

    func setLayout() {
        card.snp.makeConstraints { card in
            card.width.equalTo(200)
            card.height.equalTo(300)
            card.centerX.equalTo(view)
            card.centerY.equalTo(view)
        }
    }

    func updateUser(userName _: String) {
        // user data UI에 업데이트하기
    }
}
