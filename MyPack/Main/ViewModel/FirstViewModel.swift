//
//  FirstViewModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import UIKit

class FirstViewModel {
    var mainTabBarCoordinator: MainTabBarCoordinator?

    let title: String
    let message: String
    @Published var userName: String = ""

    init(userName: String, mainTabBarCoordinator: MainTabBarCoordinator) {
        self.title = "First"
        self.message = "This is the first tab."
        setUser(userName: userName)
        self.mainTabBarCoordinator = mainTabBarCoordinator
    }

    func setUser(userName: String) {
        self.userName = userName
    }

    func toSearch() {
        mainTabBarCoordinator?.toSearchView()
    }
}
