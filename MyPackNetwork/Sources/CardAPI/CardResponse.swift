//
//  CardResponse.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/07.
//

import Foundation

struct CardResponse: Codable {
    var id: Int
    var title: String
    var content: String
    var imageUrl: String
    var color: String
    var theme: String
    var likeCount: Int
    var commentCount: Int
    var memberName: String
    var createdAt: String
    var updatedAt: String

    func toDto() -> CardDto {
        return CardDto(
            id: id,
            title: title,
            content: content,
            imageUrl: imageUrl,
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

struct CardListResponse: Codable {
    var content: [CardResponse]
    var number: Int
    var sort: SortResponse
    var pageable: PageableResponse
    var first: Bool
    var numberOfElements: Int
    var last: Bool
    var empty: Bool

    func toDto() -> CardListDto {
        return CardListDto(
            content: content,
            number: number,
            sort: sort.toDto(),
            pageable: pageable.toDto(),
            first: first,
            numberOfElements: numberOfElements,
            last: last,
            empty: empty
        )
    }
}

struct SortResponse: Codable {
    var empty: Bool
    var sorted: Bool
    var unsorted: Bool

    func toDto() -> SortDto {
        return SortDto(empty: empty, sorted: sorted, unsorted: unsorted)
    }
}

struct PageableResponse: Codable {
    var offset: Int
    var sort: SortResponse
    var pageNumber: Int
    var pageSize: Int
    var paged: Bool
    var unpaged: Bool

    func toDto() -> PageableDto {
        return PageableDto(
            offset: offset,
            sort: sort.toDto(),
            pageNumber: pageNumber,
            pageSize: pageNumber,
            paged: paged,
            unpaged: unpaged
        )
    }
}
