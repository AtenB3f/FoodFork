//
//  TabBarItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit
import SnapKit

class TabBarItemView: UIView {
    // initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience init(frame: CGRect = .zero, type: TabBarType) {
        self.init(frame: frame)
        self.type = type

        setLayout()
        setAttribute()
    }

    // variable
    var type: TabBarType?

    private(set) var isSelected: Bool = false

    let item: UIImageView = UIImageView()

    func setLayout() {
        self.addSubview(item)

        item.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }

    func setAttribute() {
        item.image = type?.icon(false)
    }

    func select(_ isSelected: Bool) {
        self.isSelected = isSelected
        item.image = type?.icon(isSelected)
    }
}
