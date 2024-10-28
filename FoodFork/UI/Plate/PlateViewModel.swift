//
//  PlateViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/19.
//

import Foundation
import RxCocoa

class PlateViewModel {
//    var currentPosition
    
    var forkInfo = BehaviorRelay(value: [ForkInfoModel]())
    
    func loadFork() {
        let objects = RealmManager.shared.getList(objcet: ForkInfoObject.self)
        forkInfo.accept(objects.map { $0.toModel() })
    }
}
