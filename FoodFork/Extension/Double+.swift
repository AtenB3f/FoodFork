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
     : 소수점이 있는 경우에는 소수점 첫재 자리까지 보여준다.
     : 소수점이 없을 땐 소수점이 안보이도록 보여준다.
     */
    var toStarRateString: String {
        if self == 0.0 { return "0" }

        let formatNumber = floor(self * 10)
        let number = formatNumber / 10
        let remainNumber = number.truncatingRemainder(dividingBy: 1.0)

        if remainNumber == 0.0 {
            return "\(Int(number))"
        } else {
            return String(format: "%.1f", number)
        }
    }
}
