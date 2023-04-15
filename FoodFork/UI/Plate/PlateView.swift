//
//  PlateView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/12.
//

import UIKit

class PlateView: UIView, ViewLayout {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let header = HeaderView(title: "플레이트")

    let map = PlateMapView()

    func setLayout() {
        self.addSubview(header)
        self.addSubview(map)

        header.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(header.height)
        }

        map.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
            $0.bottom.equalToSuperview().inset(30)
        }
    }

    func setAttribute() {
    }
}
