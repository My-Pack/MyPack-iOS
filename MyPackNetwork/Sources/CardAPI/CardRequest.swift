//
//  CardRequest.swift
//  MyPackNetwork
//
//  Created by jito on 2023/06/07.
//

import Foundation

public struct CardRequest: Codable {
    public init(title: String, content: String, imageId: Int, color: String, theme: String) {
        self.title = title
        self.content = content
        self.imageId = imageId
        self.color = color
        self.theme = theme
    }

    var title: String
    var content: String
    var imageId: Int
    var color: String
    var theme: String
}
