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
    private var objectForks: [ForkInfoObject] = []
    var forkInfo = BehaviorRelay(value: [ForkInfoModel]())

    func loadFork() {
        objectForks = ForkDataManager.main.objectForks
        forkInfo.accept(objectForks.map { $0.toModel() })
    }

    func deleteFork(_ uuid: String) {
        if let fork = objectForks.first(where: { $0.uuid == uuid }) {
            ForkDataManager.main.delete(fork)
            loadFork()
        }
    }
}
