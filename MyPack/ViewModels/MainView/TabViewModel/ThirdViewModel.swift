//
//  ThirdViewModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class ThirdViewModel: TabViewModelProtocol {
    let title: String
    let message: String

    init() {
        self.title = "Third"
        self.message = "This is the third tab."
    }
}
