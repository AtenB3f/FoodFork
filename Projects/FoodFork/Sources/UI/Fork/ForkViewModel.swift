//
//  ForkViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/13.
//

import Foundation
import RxSwift
import RxCocoa
import Data

class ForkViewModel {
    var forkInfo = BehaviorRelay(value: [ForkInfoModel]())

    func loadFork() {
        let objects = RealmManager.shared.getList(objcet: ForkInfoObject.self)
        forkInfo.accept(objects.map { $0.toModel() })
    }
}
