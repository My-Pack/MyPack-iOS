//
//  mainTabBarVM.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class MainTabBarViewModel {
    // 각 탭의 모델 데이터
    private let tabs: [MainTabBarModel] = [
        MainTabBarModel(identifier: "first", title: "First"),
        MainTabBarModel(identifier: "second", title: "Second"),
        MainTabBarModel(identifier: "third", title: "Third")
    ]
    // 각 탭의 뷰모델
    private lazy var firstViewModel = FirstViewModel()
    private lazy var secondViewModel = SecondViewModel()
    private lazy var thirdViewModel = ThirdViewModel()

    var user: UserModel?

    init() {}

    // 각 탭의 식별자
    func identifier(at index: Int) -> String {
        return tabs[index].identifier
    }

    // 각 탭의 타이틀
    func title(at index: Int) -> String {
        return tabs[index].title
    }

    // 각 탭의 뷰모델 반환
    func viewModel(for identifier: String) -> Any {
        switch identifier {
        case "first":
            firstViewModel.user = user
            return firstViewModel
        case "second":
            return secondViewModel
        case "third":
            return thirdViewModel
        default:
            fatalError("Invalid identifier")
        }
    }
}
