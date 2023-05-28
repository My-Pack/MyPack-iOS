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

    func start(userName: String) {
        let viewModel = MainTabBarViewModel()
        viewModel.mainTabCoordinator = self
        let mainTabBarViewController = MainTabBarViewController(viewModel: viewModel)

        let firstViewModel = FirstViewModel(userName: userName, mainTabBarCoordinator: self)
        let firstViewController = FirstViewController(viewModel: firstViewModel)
        firstViewController.tabBarItem = UITabBarItem(title: viewModel.title(at: 0), image: UIImage(systemName: "1.circle"), tag: 0)

        let secondViewModel = SecondViewModel()
        let secondViewController = SecondViewController(viewModel: secondViewModel)
        secondViewController.tabBarItem = UITabBarItem(title: viewModel.title(at: 1), image: UIImage(systemName: "plus.circle"), tag: 1)

        let thirdViewModel = ThirdViewModel()
        let thirdViewController = ThirdViewController(viewModel: thirdViewModel)
        thirdViewController.tabBarItem = UITabBarItem(title: viewModel.title(at: 2), image: UIImage(systemName: "3.circle"), tag: 2)

        mainTabBarViewController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        navigationController?.pushViewController(mainTabBarViewController, animated: true)
    }

    func toSearchView() {
        let searchViewCoordinator = SearchViewCoordinatorImpl(navigationController: navigationController)
        searchViewCoordinator.start()
    }

    func toSecondView(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
