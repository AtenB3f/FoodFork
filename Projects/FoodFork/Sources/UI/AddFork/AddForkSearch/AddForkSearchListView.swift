//
//  AddForkSearchListView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import UIKit
import Design

class AddForkSearchListView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link

        }
    }

    let itemHeight: CGFloat = 104

    func setLayout() {
    }

    func setAttribute() {
        self.backgroundColor = .white
        self.separatorStyle = .none
        self.allowsSelection = true
        self.rowHeight = AddForkSearchItemView.height
        self.showsVerticalScrollIndicator = false
    }
}
