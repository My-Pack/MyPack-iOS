//
//  mainTabBarVM.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import UIKit

class MainTabBarViewModel {
    private let tabs: [Tab] = [.first, .second, .third]

    func getTabsCount() -> Int {
        return tabs.count
    }

    func identifier(at index: Int) -> String {
        return tabs[index].rawValue
    }

    func title(at index: Int) -> String {
        return tabs[index].title
    }
}
