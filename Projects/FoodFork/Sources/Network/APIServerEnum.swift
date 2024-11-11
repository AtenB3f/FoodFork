//
//  APIServerEnum.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/18/24.
//

import Foundation

enum APIType {
    // kakao API
    case kakaoSearchKeyword(keyword: String, page: Int, size: Int = 15, sort: String = "accuracy")
}

enum NetworkMethod: String {
    case get
    case post
    case put
    case delete
}
