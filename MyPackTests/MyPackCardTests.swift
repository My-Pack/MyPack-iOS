//
//  MyPackCardTests.swift
//  MyPackTests
//
//  Created by jito on 2023/06/06.
//

import Foundation

@testable import MyPack
@testable import MyPackNetwork
import XCTest

final class MyPackCardTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

//    func testUploadImage() async throws {
//        let api = CardAPI()
//        let cardRequest = CardRequest(title: "title", content: "content", imageId: 35, color: "red", theme: "christmas")
//        let result = try await api.uploadData(token: "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ3bmVoZHRqcjVAZ21haWwuY29tIiwicm9sZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfVVNFUiJ9XSwiZXhwIjoxNjg2MDQxMDI3fQ.DOMWRD9WN8QwjbgraMBeH1DPo4NKBCGyPwxMlG5L0_-OArYdBbU0Ivtcp0pShUM0ML5koKDiyQ7IjnawGyyA0A", request: cardRequest)
//        print(result)
//        XCTAssertTrue(type(of: result) == CardDto.self, "Expected result to be of type ImageDto")
//    }

    func testPerformanceExample() throws {
        measure {}
    }
}
