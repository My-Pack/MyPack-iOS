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

    func testLogin() {
        let expectation = self.expectation(description: "loggedIn event triggered")

        // GIVEN
        class MockLoginCoordinator: LoginCoordinator {
            override func showMain(user _: UserModel) {}
        }
        let mockCoordinator = MockLoginCoordinator(navigationController: nil)
        let loginViewModel = LoginViewModel(loginCoordinator: mockCoordinator)

        loginViewModel.loggedInListener = { userData in
            // THEN
            XCTAssertEqual(userData.name, "jito", "User name should be 'jito'")
            expectation.fulfill()
        }
        EventManager.shared.addObserver(for: "loggedIn", listener: loginViewModel.loggedInListener!)

        // WHEN
        loginViewModel.login()

        waitForExpectations(timeout: 5)
    }
}
