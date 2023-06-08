//
//  LoginCoordinatorProtocol.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import Foundation

protocol LoginCoordinator: Coordinator {
    func start()

    @MainActor
    func didLoginSuccessfully(userName: String)
}
