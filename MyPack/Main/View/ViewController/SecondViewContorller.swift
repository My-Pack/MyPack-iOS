//
//  SecondViewContorller.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

// MARK: - 뷰컨트롤러 생성자

class SecondViewController: UIViewController {
    private let viewModel: SecondViewModel

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Make it!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    let plusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        btn.tintColor = .white
        btn.addAction(UIAction(handler: { _ in
            print("만들기")
        }), for: .touchUpInside)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 16
        return btn
    }()

    init(viewModel: SecondViewModel) {
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

extension SecondViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
        setLayout()
    }
}

// MARK: - 뷰모델 관련

private extension SecondViewController {
    func setBindings() {}
}

// MARK: - UI 관련

extension SecondViewController {
    func addUI() {
        view.addSubview(plusBtn)
        view.addSubview(titleLabel)
    }

    func setLayout() {
        plusBtn.snp.makeConstraints { btn in
            btn.width.equalTo(280)
            btn.height.equalTo(400)
            btn.center.equalTo(self.view)
        }
        titleLabel.snp.makeConstraints { label in
            label.top.equalTo(view.safeAreaLayoutGuide)
            label.leading.equalTo(16)
        }
    }
}
