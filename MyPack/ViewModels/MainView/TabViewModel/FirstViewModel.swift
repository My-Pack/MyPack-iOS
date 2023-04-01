//
//  FirstViewModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import UIKit

class FirstViewModel: TabViewModelProtocol {
    let title: String
    let message: String
    @Published var user: UserModel?

    init() {
        self.title = "First"
        self.message = "This is the first tab."
    }
}
