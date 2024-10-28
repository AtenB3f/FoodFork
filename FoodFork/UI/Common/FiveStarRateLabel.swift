//
//  FiveStarRateLabel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/23/24.
//

import UIKit
import SnapKit

class FiveStarRateLabel: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(frame: CGRect = .zero, rate: Double) {
        self.init(frame: frame)
        self.rate = rate

    }

    var rate: Double = .zero
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()

    private var icon1: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(named: "Star_On")!
        view.contentMode = .scaleAspectFill

        return view
    }()
    
    private var icon2: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(named: "Star_On")!
        view.contentMode = .scaleAspectFill

        return view
    }()
    
    private var icon3: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(named: "Star_On")!
        view.contentMode = .scaleAspectFill

        return view
    }()
    
    private var icon4: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(named: "Star_On")!
        view.contentMode = .scaleAspectFill

        return view
    }()
    
    private var icon5: UIImageView = {
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
        self.addSubview(stack)
        self.addSubview(label)
        [icon1, icon2, icon3, icon4, icon5].forEach { stack.addArrangedSubview($0) }
        
        stack.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }

        label.snp.makeConstraints { make in
            make.left.equalTo(stack.snp.right).offset(2)
            make.centerY.equalToSuperview()
        }
    }

    func setText(rate: Double) {
        label.text = rate.toStarRateString
        let arr = [icon1, icon2, icon3, icon4, icon5]
        let count = Int(rate)
        for i in 0..<count {
            if i <= count {
                arr[i].image = UIImage(named: "Star_On")
            } else {
                arr[i].image = UIImage(named: "Star_Off")
            }
        }
    }
}
