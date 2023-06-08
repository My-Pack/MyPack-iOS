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
        let searchViewCoordinator = SearchViewCoordinatorImpl(navigationController: navigationController)
        let viewModel = SearchViewModel(searchViewCoordinator: searchViewCoordinator)
        let searchViewController = SearchViewController(viewModel: viewModel)
        navigationController?.pushViewController(searchViewController, animated: false)
    }
}
