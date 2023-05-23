//
//  SearchViewCoordinatorImpl.swift
//  MyPack
//
//  Created by jito on 2023/05/23.
//

import UIKit

class SearchViewCoordinatorImpl: SearchViewCoordinator {
    let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let searchViewController = SearchViewController()
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}
