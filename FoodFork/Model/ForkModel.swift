//
//  ForkModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import Foundation

struct ForkInfoModel {
    var name: String
    var address: String
    var rate: Double
}

struct StoreInfoModel: Identifiable {
    let id = UUID()
    var store: String
    var address: String
    var lotNumber: String
}
