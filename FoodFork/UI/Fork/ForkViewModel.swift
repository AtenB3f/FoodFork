//
//  ForkViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/13.
//

import Foundation

class ForkViewModel {
    var forkListInfo: [String] = []

    var forkInfo: [ForkInfoModel] = []
    
    func loadFork() {
        let objects = RealmManager.shared.getList(objcet: ForkInfoObject.self)
        forkInfo = objects.map { $0.toModel() }
        print(forkInfo)
    }
}
