//
//  APIError.swift
//  MyPackNetwork
//
//  Created by jito on 2023/04/01.
//

import Foundation

public enum APIError: Error {
    case requestFailed
    case invalidURL
    case decodingFailed
}
