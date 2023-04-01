//
//  MainTabBarViewModelTests.swift
//  MyPackTests
//
//  Created by jito on 2023/04/02.
//

@testable import MyPack
import XCTest

class MainTabBarViewModelTests: XCTestCase {
    var viewModel: MainTabBarViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MainTabBarViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testIdentifierAtIndex() {
        let firstIdentifier = viewModel.identifier(at: 0)
        XCTAssertEqual(firstIdentifier, "first")

        let secondIdentifier = viewModel.identifier(at: 1)
        XCTAssertEqual(secondIdentifier, "second")

        let thirdIdentifier = viewModel.identifier(at: 2)
        XCTAssertEqual(thirdIdentifier, "third")
    }

    func testTitleAtIndex() {
        let firstTitle = viewModel.title(at: 0)
        XCTAssertEqual(firstTitle, "First")

        let secondTitle = viewModel.title(at: 1)
        XCTAssertEqual(secondTitle, "Second")

        let thirdTitle = viewModel.title(at: 2)
        XCTAssertEqual(thirdTitle, "Third")
    }
}
