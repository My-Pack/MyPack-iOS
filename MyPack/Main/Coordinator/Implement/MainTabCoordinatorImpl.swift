//
//  MainTabCoordinatorImpl.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import UIKit

class MainTabBarCoordinatorImpl: MainTabBarCoordinator {
    let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start(userModel: UserModel) {
        let viewModel = MainTabBarViewModel()
        let mainTabBarViewController = MainTabBarViewController(viewModel: viewModel)

        let firstViewModel = FirstViewModel(userModel: userModel)
        let firstViewController = FirstViewController(viewModel: firstViewModel)
        firstViewController.tabBarItem = UITabBarItem(title: viewModel.title(at: 0), image: UIImage(systemName: "1.circle"), tag: 0)

        let secondViewModel = SecondViewModel()
        let secondViewController = SecondViewController(viewModel: secondViewModel)
        secondViewController.tabBarItem = UITabBarItem(title: viewModel.title(at: 1), image: UIImage(systemName: "2.circle"), tag: 1)

        let thirdViewModel = ThirdViewModel()
        let thirdViewController = ThirdViewController(viewModel: thirdViewModel)
        thirdViewController.tabBarItem = UITabBarItem(title: viewModel.title(at: 2), image: UIImage(systemName: "3.circle"), tag: 2)

        mainTabBarViewController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        navigationController?.pushViewController(mainTabBarViewController, animated: true)
    }
}
