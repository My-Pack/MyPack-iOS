//
//  CardService.swift
//  MyPack
//
//  Created by jito on 2023/06/06.
//

import MyPackNetwork
import UIKit

protocol CardService {
    func uploadImage(token: String, image: Data, fileName: String) async throws -> Int
    func uploadCard(token: String, cardRequest: CardRequest) async throws -> CardDto
}
