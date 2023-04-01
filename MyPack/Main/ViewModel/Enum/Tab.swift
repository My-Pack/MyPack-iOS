//
//  Tab.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import Foundation

enum Tab: String {
    case first
    case second
    case third

    var title: String {
        switch self {
        case .first:
            return "First"
        case .second:
            return "Second"
        case .third:
            return "Third"
        }
    }
}
