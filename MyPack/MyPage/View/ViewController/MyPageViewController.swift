//
//  MyPageViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/04/16.
//

import UIKit

// MARK: - 뷰컨트롤러 생성자
class MyPageViewController: UIViewController {
//    var mypageViewModel: MyPageViewModel

//    init(mypageViewModel: MyPageViewModel) {
//        self.mypageViewModel = mypageViewModel
//        super.init(nibName: nil, bundle: nil)
//    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 뷰컨트롤러 생성자

extension MyPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = loginViewModel.gradientColor()
//        addUI()
    }
}

// MARK: - UI 관련

//extension MyPageViewController {
//    func addUI() {
//        view.addSubview(boxView)
//    }
//}
