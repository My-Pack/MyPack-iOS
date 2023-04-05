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

    init(userName: String) {
        self.title = "First"
        self.message = "This is the first tab."
        setUser(userName: userName)
    }

    func setUser(userName: String) {
        self.userName = userName
    }
}
