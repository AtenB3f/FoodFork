//
//  ForkDetailViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 9/17/24.
//

import UIKit
import RxCocoa
import KakaoMapsSDK

class ForkDetailViewModel {
    var forkInfo:ForkInfoModel? {
        didSet {
            if let x = forkInfo?.x, let y = forkInfo?.y {
                guard let x = Double(x), let y = Double(y) else { return }
                mapPoint = MapPoint(longitude: x, latitude: y)
            }
            if let pic = forkInfo?.pictures {
                pictures.accept(pic)
            }
        }
    }
    
    var pictures = BehaviorRelay(value: [UIImage]())
    
    var mapPoint = MapPoint(longitude: 126.978365, latitude: 37.566691)
}
