//
//  Double+.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/14.
//

import Foundation

extension Double {
    /*
     [toStarRateString]
     : 별점을 표기할 때 사용
     : 소수점 첫재 자리까지 보여준다.
     */
    var toStarRateString: String {
        return String(format: "%.1f", self)
    }
}
