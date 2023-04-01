//
//  APIClient.swift
//  MyPackNetwork
//
//  Created by jito on 2023/04/01.
//

import Foundation

public class APIClient {
    public init() {}

    public func fetchData(completion: @escaping (Result<String, APIError>) -> Void) {
        // 여기에 네트워킹 코드를 작성하세요.
        // 예: URLSession을 사용한 HTTP 요청, JSON 디코딩 등

        // 결과를 반환합니다.
        completion(.success("성공"))
    }
}
