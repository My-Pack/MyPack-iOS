//
//  SearchViewModel.swift
//  MyPack
//
//  Created by jito on 2023/05/23.
//

import Foundation

class SearchViewModel {
    var searchViewCoordinator: SearchViewCoordinator?

    init(searchViewCoordinator: SearchViewCoordinator? = nil) {
        self.searchViewCoordinator = searchViewCoordinator
    }

    func toMain() {
        searchViewCoordinator?.navigationController?.popViewController(animated: false)
    }
}
