//
//  mainTabBarView.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    var coordinator: MainCoordinator?
    private let viewModel = MainTabBarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 각 탭에 대한 뷰컨트롤러 생성 및 설정
        let firstVC = FirstViewController(viewModel: viewModel.viewModel(for: viewModel.identifier(at: 0)) as! FirstViewModel)
        firstVC.tabBarItem = UITabBarItem(title: viewModel.title(at: 0), image: UIImage(systemName: "1.circle"), tag: 0)

        let secondVC = SecondViewController(viewModel: viewModel.viewModel(for: viewModel.identifier(at: 1)) as! SecondViewModel)
        secondVC.tabBarItem = UITabBarItem(title: viewModel.title(at: 1), image: UIImage(systemName: "2.circle"), tag: 1)

        let thirdVC = ThirdViewController(viewModel: viewModel.viewModel(for: viewModel.identifier(at: 2)) as! ThirdViewModel)
        thirdVC.tabBarItem = UITabBarItem(title: viewModel.title(at: 2), image: UIImage(systemName: "3.circle"), tag: 2)

        // 생성한 뷰컨트롤러들을 탭바에 추가
        viewControllers = [firstVC, secondVC, thirdVC]
    }
}
