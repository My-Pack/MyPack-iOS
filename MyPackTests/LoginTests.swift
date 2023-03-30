//
//  LoginTests.swift
//  MyPackTests
//
//  Created by jito on 2023/03/30.
//

@testable import MyPack
import XCTest

final class LoginTests: XCTestCase {
    let loginViewModel: LoginViewModel = .init()
    let mainTabViewModel: MainTabBarViewModel = .init()

    func testLogin() throws {
        loginViewModel.login()
        XCTAssertEqual(mainTabViewModel.user, UserModel(name: "jito"))
    }
}
