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
        setBindings()
        view.backgroundColor = .white
        var tabBarViewControllers: [UIViewController] = []

        // 각 탭에 대한 뷰컨트롤러 생성 및 설정
        if let firstViewModel = viewModel.viewModel(for: viewModel.identifier(at: 0)) as? FirstViewModel {
            let firstVC = FirstViewController(viewModel: firstViewModel)
            firstVC.tabBarItem = UITabBarItem(title: viewModel.title(at: 0), image: UIImage(systemName: "1.circle"), tag: 0)
            tabBarViewControllers.append(firstVC)
        }

        if let secondViewModel = viewModel.viewModel(for: viewModel.identifier(at: 1)) as? SecondViewModel {
            let secondVC = SecondViewController(viewModel: secondViewModel)
            secondVC.tabBarItem = UITabBarItem(title: viewModel.title(at: 1), image: UIImage(systemName: "2.circle"), tag: 1)
            tabBarViewControllers.append(secondVC)
        }

        if let thirdViewModel = viewModel.viewModel(for: viewModel.identifier(at: 2)) as? ThirdViewModel {
            let thirdVC = ThirdViewController(viewModel: thirdViewModel)
            thirdVC.tabBarItem = UITabBarItem(title: viewModel.title(at: 2), image: UIImage(systemName: "3.circle"), tag: 2)
            tabBarViewControllers.append(thirdVC)
        }

        // 생성한 뷰컨트롤러들을 탭바에 추가
        viewControllers = tabBarViewControllers
    }
}

// MARK: - 뷰모델 관련

private extension MainTabBarViewController {
    func setBindings() {}
}
