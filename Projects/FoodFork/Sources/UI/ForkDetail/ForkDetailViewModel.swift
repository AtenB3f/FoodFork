//
//  ForkDetailViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 9/17/24.
//

import UIKit
import RxSwift
import RxCocoa
import KakaoMapsSDK
import Data
import Design

class ForkDetailViewModel {
    var forkInfo: ForkInfoModel? {
        didSet {
            if let xPoint = forkInfo?.xPoint, let yPoint = forkInfo?.yPoint {
                guard let xPoint = Double(xPoint), let yPoint = Double(yPoint) else { return }
                mapPoint = MapPoint(longitude: xPoint, latitude: yPoint)
            }
            if let pic = forkInfo?.pictures {
                pictures.accept(pic)
            }
        }
    }

    var pictures = BehaviorRelay(value: [UIImage]())

    var mapPoint = MapPoint(longitude: 126.978365, latitude: 37.566691)

    func copyText(_ view: UIView, _ text: String) {
        UIPasteboard.general.string = text

        if let str = UIPasteboard.general.string {
            showToast(view, message: str)
        }
    }
}
