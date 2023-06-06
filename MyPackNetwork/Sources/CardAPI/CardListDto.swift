//
//  CardListDto.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/07.
//

import Foundation

public struct CardListDto {
    var content: [CardResponse]
    var number: Int
    var sort: SortDto
    var pageable: PageableDto
    var first: Bool
    var numberOfElements: Int
    var last: Bool
    var empty: Bool
}

public struct SortDto {
    var empty: Bool
    var sorted: Bool
    var unsorted: Bool
}

public struct PageableDto {
    var offset: Int
    var sort: SortDto
    var pageNumber: Int
    var pageSize: Int
    var paged: Bool
    var unpaged: Bool
}
