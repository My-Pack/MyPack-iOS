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

//    func testUploadCard() async {
//        let api = CardAPI()
//        let cardRequest = CardRequest(title: "title", content: "content", imageId: 35, color: "red", theme: "christmas")
//
//        Task {
//            do {
//                let result = try await api.uploadData(token: "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ3bmVoZHRqcjVAZ21haWwuY29tIiwicm9sZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfVVNFUiJ9XX0.XX5SHqrg_fO4i3894XP4jrDCGYSty6PiDiQAxSXMMIf8D3XGQBewcBeinDFTylj_-ldW1aGZ9_FzFa8kXmf5KQ", request: cardRequest)
//                print(result)
//                XCTAssertTrue(type(of: result) == CardDto.self, "Expected result to be of type CardDto")
//            } catch {
//                print("Error: \(error)")
//            }
//        }
//    }

//    func testGetCardList() async {
//        let api = CardAPI()
//
//        Task {
//            do {
//                let result = try await api.getCardList(token: "")
//                print(result)
//                XCTAssertTrue(type(of: result) == CardListDto.self, "Expected result to be of type CardDto")
//            } catch {
//                print("Error: \(error)")
//            }
//        }
//    }

    func testPerformanceExample() throws {
        measure {}
    }
}
