//
//  MainCoordinator.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toMain() {
        let mainTabBarViewController = MainTabBarViewController()
        mainTabBarViewController.coordinator = self
        navigationController.pushViewController(mainTabBarViewController, animated: true)
    }
}
