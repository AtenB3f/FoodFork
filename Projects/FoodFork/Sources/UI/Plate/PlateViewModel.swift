//
//  PlateViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa
import KakaoMapsSDK
import Data
import Design

class PlateViewModel {
    var forkInfo = BehaviorRelay(value: [ForkInfoModel]())
    var selectFork: BehaviorRelay<ForkInfoModel?> = BehaviorRelay(value: nil)
    var mapPoint: BehaviorRelay<ForkPoint> = BehaviorRelay(value: ForkPoint(x: 127.108678, y: 37.402001))
//    var mapPoint: Observable<CGPoint> = .just(CGPoint(x: 127.108678, y: 37.402001))

    var mapController: KMController?

    func setMapController(_ viewContainer: KMViewContainer) {
        mapController = KMController(viewContainer: viewContainer)
    }

    func selectFork(fork: ForkInfoModel) {
        if let prevUuid = selectFork.value?.uuid?.uuidString {
            changePoiStyle(isOnOff: false, uuid: prevUuid)
        }
        selectFork.accept(fork)
        if let point = fork.getPoint() {
            mapPoint.accept(point)
        }
        if let uuid = fork.uuid?.uuidString {
            changePoiStyle(isOnOff: true, uuid: uuid)
        }
    }

    func selectFork(uuid: String) {
        let uuid = UUID(uuidString: uuid)
        if let item = forkInfo.value.first(where: { $0.uuid == uuid }) {
            selectFork(fork :item)
        }
    }

    func loadFork() {
        let objects = RealmManager.shared.getList(objcet: ForkInfoObject.self)
        forkInfo.accept(objects.map { $0.toModel() })
        if let first = objects.first,
            let xPoint = Double(first.xPoint),
           let yPoint = Double(first.yPoint) {
            let point = ForkPoint(x: xPoint, y: yPoint)
            mapPoint.accept(point)
            print(mapPoint.value.x, mapPoint.value.y)
        }
    }

    func changePoiStyle(isOnOff: Bool, uuid: String) {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        let labelManager = mapView?.getLabelManager()
        if let labelLayer = labelManager?.getLabelLayer(layerID: "PoiLayer") {
            labelLayer
                .getPoi(poiID: uuid)?
                .changeStyle(styleID: isOnOff ? "PoiOnStyle" : "PoiOffStyle",
                             enableTransition: true)
        }
    }

    func copyText(_ view: UIView, _ text: String) {
        UIPasteboard.general.string = text

        if let str = UIPasteboard.general.string {
            showToast(view, message: str)
        }
    }
}
