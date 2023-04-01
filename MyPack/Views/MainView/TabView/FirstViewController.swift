//
//  FirstViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import UIKit

// MARK: - 뷰컨트롤러 생성자

class FirstViewController: UIViewController {
    private let viewModel: FirstViewModel
    private var disposableBag = Set<AnyCancellable>()
    private var user: UserModel?
    private var text: UITextView = .init(frame: CGRect(x: 100, y: 100, width: 100, height: 50))

    init(viewModel: FirstViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        setUI()
    }
}

// MARK: - 뷰모델 관련

private extension FirstViewController {
    func setBindings() {
        viewModel.$user.sink { user in
            self.user = user
            print("user: \(String(describing: user?.name))")
        }.store(in: &disposableBag)
    }
}

// MARK: - UI 관련

private extension FirstViewController {
    func setUI() {
        text.text = user?.name
        view.addSubview(text)
    }
}
