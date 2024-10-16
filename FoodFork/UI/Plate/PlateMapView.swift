//
//  PlateMapView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/19.
//

import UIKit
import SnapKit

class PlateMapView: UIView, ViewLayout {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    var map: MTMapView = {
//        let map = MTMapView()
//        var latitude: Double = 37.576568
//        var longitude: Double = 127.029148
//        map.baseMapType = .standard
////        map.currentLocationTrackingMode = .onWithoutHeading
//        map.showCurrentLocationMarker = true
//        map.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude)), animated: true)
//
//        return map
//    }()

    func setLayout() {
//        self.addSubview(map)
//
//        map.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }

    func setAttribute() {
    }
}
