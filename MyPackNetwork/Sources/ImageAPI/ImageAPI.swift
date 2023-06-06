//
//  ImageAPI.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/06.
//

import UIKit

struct ImageRequest: Codable {
    var imageData: Data
}

struct ImageResponse: Codable {
    var id: Int
    var originalName: String
    var storedName: String
    var s3Url: String
    var isUse: Bool

    func toDto() -> ImageDto {
        return ImageDto(id: id, originalName: originalName, storedName: storedName, s3Url: s3Url, isUse: isUse)
    }
}

public class ImageAPI {
    public init() {}

    public func uploadImage(image: Data, fileName: String) async throws -> ImageDto {
        do {
            let data = try await APIClient.shared.uploadImage(endPoint: "/images", imageData: image, fileName: fileName)
            let imageResponse = try JSONDecoder().decode(ImageResponse.self, from: data)
            return imageResponse.toDto()
        } catch {
            throw error
        }
    }
}
