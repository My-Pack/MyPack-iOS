//
//  SearchViewController.swift
//  MyPack
//
//  Created by jito on 2023/05/23.
//

import UIKit

// MARK: - 뷰컨트롤러 생성자

class SearchViewController: UIViewController {
    var viewModel: SearchViewModel

    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        textField.addLeftPadding()
        textField.textColor = .black
        textField.becomeFirstResponder()
        return textField
    }()

    let backBtn: BackBtn

    let magnifying: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .white
        btn.addAction(UIAction(handler: { _ in
            print("검색")
        }), for: .touchUpInside)
        return btn
    }()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.backBtn = BackBtn(viewModel: viewModel)

        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .darkGray
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
        addUI()
        setLayout()
    }
}

// MARK: - 뷰모델 관련

private extension SearchViewController {
    func setBindings() {}
}

private extension SearchViewController {
    func addUI() {
        view.addSubview(textField)
        view.addSubview(backBtn)
        view.addSubview(magnifying)
    }

    func setLayout() {
        textField.snp.makeConstraints { tf in
            tf.width.equalTo(UIScreen.main.bounds.width - 112)
            tf.height.equalTo(40)
            tf.top.equalTo(view.safeAreaLayoutGuide)
            tf.centerX.equalTo(view)
        }
        backBtn.snp.makeConstraints { btn in
            btn.width.equalTo(40)
            btn.height.equalTo(40)
            btn.leading.equalTo(10)
            btn.top.equalTo(view.safeAreaLayoutGuide)
        }
        magnifying.snp.makeConstraints { btn in
            btn.width.equalTo(40)
            btn.height.equalTo(40)
            btn.trailing.equalTo(-10)
            btn.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
