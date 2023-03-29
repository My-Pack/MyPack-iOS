//
//  mainTabBarVM.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class mainTabBarViewModel {
    
    // 각 탭의 모델 데이터
    private let tabs: [mainTab] = [
        mainTab(identifier: "first", title: "First"),
        mainTab(identifier: "second", title: "Second"),
        mainTab(identifier: "third", title: "Third")
    ]
    // 각 탭의 뷰모델
    private lazy var firstViewModel = FirstViewModel()
    private lazy var secondViewModel = SecondViewModel()
    private lazy var thirdViewModel = ThirdViewModel()
    
    // 탭의 개수
    var numberOfTabs: Int {
        return tabs.count
    }
    
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

