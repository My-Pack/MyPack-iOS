//
//  mainTabBarView.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

// MARK: - 뷰컨트롤러 생성자

class MainTabBarViewController: UITabBarController {
    private let viewModel: MainTabBarViewModel

    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 뷰컨트롤러 라이프사이클

extension MainTabBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = .white
        setBindings()
    }
}

// MARK: - 뷰모델 관련

private extension MainTabBarViewController {
    func setBindings() {}
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == viewControllers?[1] {
            let secondViewModel = SecondViewModel(mainTabBarCoordinator: viewModel.mainTabCoordinator!)
            let secondViewController = SecondViewController(viewModel: secondViewModel)
            viewModel.mainTabCoordinator?.toSecondView(vc: secondViewController)
            return false
        }

        return true
    }
}
