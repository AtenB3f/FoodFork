//
//  PlateViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/19.
//

import Foundation
import RxSwift
import RxCocoa
import KakaoMapsSDK
import Data


class PlateViewModel {
    var forkInfo = BehaviorRelay(value: [ForkInfoModel]())
    var selectFork: BehaviorRelay<ForkInfoModel?> = BehaviorRelay(value: nil)
//    var selectForkPoiId: String = ""
    var mapPoint: BehaviorRelay<ForkPoint> = BehaviorRelay(value: ForkPoint(x: 127.108678, y: 37.402001))
//    var mapPoint: Observable<CGPoint> = .just(CGPoint(x: 127.108678, y: 37.402001))
    
    func selectFork(_ fork: ForkInfoModel) {
        selectFork.accept(fork)
        if let point = fork.getPoint() {
            mapPoint.accept(point)
        }
    }
    
    func selectFork(uuid: String) {
        let uuid = UUID(uuidString: uuid)
        if let item = forkInfo.value.first(where: { $0.uuid == uuid }) {
            selectFork.accept(item)
            selectFork(item)
        }
    }
    
    func loadFork() {
        let objects = RealmManager.shared.getList(objcet: ForkInfoObject.self)
        forkInfo.accept(objects.map { $0.toModel() })
        if let first = objects.first, let x = Double(first.x), let y = Double(first.y) {
            let point = ForkPoint(x: x, y: y)
            mapPoint.accept(point)
            print(mapPoint.value.x, mapPoint.value.y)
        }
    }
}
