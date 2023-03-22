//
//  MyPackUITests.swift
//  MyPackUITests
//
//  Created by jito on 2023/03/16.
//

// testcode 예시
import XCTest

final class MyPackUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        // text
        let title = app.staticTexts["Log In"]
        XCTAssertTrue(title.exists, "Log In label not found")
        
        // textfield
        let usernameField = app.textFields["Username"]
        XCTAssertTrue(usernameField.exists)
        
        usernameField.tap()
        usernameField.typeText("mypack")
        
        // securetextfield
        let passwordSecureTestField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTestField.exists)
        passwordSecureTestField.tap()
        passwordSecureTestField.typeText("password")
        
        // button
        let button = app.buttons["Continue"]
        XCTAssertTrue(button.exists)
        button.tap()
        
        // 성공 후 text
        let accountLabel = app.staticTexts["Welcome, MyPack!"]
        XCTAssertTrue(accountLabel.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
