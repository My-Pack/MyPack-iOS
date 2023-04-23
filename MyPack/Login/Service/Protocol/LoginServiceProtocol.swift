//
//  LoginServiceProtocol.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import Foundation

protocol LoginServiceProtocol {
    func login(token: String) async throws -> UserModel?
}
