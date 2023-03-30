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
        let expectation = self.expectation(description: "Login event is received")

        // 메인 탭바 뷰모델에서 로그인 이벤트를 기다립니다.
        mainTabViewModel.loggedInListener = { [self] _ in
            XCTAssertEqual(mainTabViewModel.user, UserModel(name: "jito"))
            expectation.fulfill()
        }
        EventManager.shared.addObserver(for: "loggedIn", listener: mainTabViewModel.loggedInListener!)

        // 로그인을 시도합니다.
        loginViewModel.login()

        // 이벤트를 받을 때까지 기다립니다.
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func tearDown() {
        // 테스트가 끝나면 옵저버를 제거합니다.
        EventManager.shared.removeObserver(for: "loggedIn")
    }
}
