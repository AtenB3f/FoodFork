//
//  StarRateLabel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/14.
//

import UIKit
import SnapKit

class StarRateLabel: UIView, ViewLayout {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(frame: CGRect = .zero, rate: Double) {
        self.init(frame: frame)
        self.rate = rate

        setLayout()
        setAttribute()
    }

    var rate: Double = .zero

    private var icon: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(named: "Star_On")!
        view.contentMode = .scaleAspectFill

        return view
    }()

    private var label: UILabel = {
        let label = UILabel()

        label.textColor = .Brand.main30
        label.font = .fontBody2

        return label
    }()

    func setLayout() {
        self.addSubview(icon)
        self.addSubview(label)

        icon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }

        label.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(2)
            make.centerY.equalToSuperview()
        }
    }

    func setAttribute() {
        label.text = self.rate.toStarRateString
    }

    func setText(rate: Double) {
        label.text = rate.toStarRateString
    }
}
