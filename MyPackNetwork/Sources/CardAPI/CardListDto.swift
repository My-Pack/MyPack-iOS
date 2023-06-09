//
//  CardListDto.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/07.
//

import Foundation

public struct CardListDto {
    public var content: [CardResponse]
    public var number: Int
    public var sort: SortDto
    public var pageable: PageableDto
    public var first: Bool
    public var numberOfElements: Int
    public var last: Bool
    public var empty: Bool
}

public struct SortDto {
    public var empty: Bool
    public var sorted: Bool
    public var unsorted: Bool
}

public struct PageableDto {
    public var offset: Int
    public var sort: SortDto
    public var pageNumber: Int
    public var pageSize: Int
    public var paged: Bool
    public var unpaged: Bool
}
