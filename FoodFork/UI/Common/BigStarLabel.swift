//
//  BigStarLabel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/23/24.
//

import UIKit
import SnapKit

class BigStarLabel: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(frame: CGRect = .zero,
                     rate: Double,
                     textColor: UIColor = .Text.light20,
                     font: UIFont = .fontSubtitle2) {
        self.init(frame: frame)
        self.rate = rate
        label.font = font
        label.textColor = textColor

        setLayout()
        setText(rate: rate)
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

        label.textColor = .Text.light20
        label.font = .fontSubtitle2

        return label
    }()

    func setLayout() {
        self.addSubview(icon)
        self.addSubview(label)

        icon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }

        label.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    func setText(rate: Double) {
        label.text = rate.toStarRateString
    }
}
