//
//  mainTabBarVM.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import UIKit

enum Tab: String {
    case first
    case second
    case third

    var title: String {
        switch self {
        case .first:
            return "First"
        case .second:
            return "Second"
        case .third:
            return "Third"
        }
    }
}

class MainTabBarViewModel {
    private let tabs: [Tab] = [.first, .second, .third]

    // 각 탭의 뷰모델
    private lazy var firstViewModel = FirstViewModel()
    private lazy var secondViewModel = SecondViewModel()
    private lazy var thirdViewModel = ThirdViewModel()

    @Published var user: UserModel?

    init() {}

    // 각 탭의 식별자
    func identifier(at index: Int) -> String {
        return tabs[index].rawValue
    }

    // 각 탭의 타이틀
    func title(at index: Int) -> String {
        return tabs[index].title
    }

    // 각 탭의 뷰모델 반환
    func viewModel(for identifier: String) -> TabViewModelProtocol {
        guard let tab = Tab(rawValue: identifier) else {
            fatalError("Invalid identifier")
        }

        switch tab {
        case .first:
            firstViewModel.user = user
            return firstViewModel
        case .second:
            return secondViewModel
        case .third:
            return thirdViewModel
        }
    }
}
