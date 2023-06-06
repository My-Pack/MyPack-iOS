//
//  MyPackImageTests.swift
//  MyPackTests
//
//  Created by jito on 2023/06/06.
//

@testable import MyPack
@testable import MyPackNetwork
import XCTest

final class MyPackImageTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testUploadImage() async throws {
        let api = ImageAPI()

        let imageData = UIImage(named: "heart")!.jpegData(compressionQuality: 1.0)!
        let result = try await api.uploadImage(image: imageData, fileName: "heart")
        print(result)
        XCTAssertTrue(type(of: result) == ImageDto.self, "Expected result to be of type ImageDto")
    }

    func testPerformanceExample() throws {
        measure {}
    }
}
