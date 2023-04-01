//
//  FirstViewModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import UIKit

class FirstViewModel {
    let title: String
    let message: String
    @Published var userName: String = ""

    init(userModel: UserModel) {
        self.title = "First"
        self.message = "This is the first tab."
        setUser(userModel: userModel)
    }

    func setUser(userModel: UserModel) {
        userName = userModel.name
    }
}
