//
//  FirstViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    private let viewModel: FirstViewModel
    private let text: UITextView = .init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

    init(viewModel: FirstViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        text.backgroundColor = .gray
        text.text = viewModel.user?.name
        view.addSubview(text)
    }
}
