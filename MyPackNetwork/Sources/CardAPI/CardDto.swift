//
//  CardDto.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/06.
//

import Foundation

public struct CardDto {
    var id: Int
    var title: String
    var content: String
    var imageId: Int
    var color: String
    var theme: String
    var likeCount: Int
    var commentCount: Int
    var memberName: String
    var createdAt: String
    var updatedAt: String

    func toResponse() -> CardResponse {
        return CardResponse(
            id: id,
            title: title,
            content: content,
            imageId: imageId,
            color: color,
            theme: theme,
            likeCount: likeCount,
            commentCount: commentCount,
            memberName: memberName,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
