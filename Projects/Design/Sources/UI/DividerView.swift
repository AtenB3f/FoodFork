//
//  DividerView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import UIKit

public class DividerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public convenience init(frame: CGRect = .zero, color: UIColor = .Other.divider) {
        self.init(frame: frame)
        self.color = color

        setLayout()
        setAttribute()
    }

    func setLayout() {
        addSubview(divider)

        divider.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func setAttribute() {
        divider.backgroundColor = color
    }

    private var color: UIColor = .Other.divider

    lazy var divider = UIView()
}
