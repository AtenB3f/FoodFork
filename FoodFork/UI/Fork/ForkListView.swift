//
//  ForkListView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/13.
//

import UIKit

class ForkListView: UITableView, ViewLayout {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var navigation: NavigationDelegate? = nil
    
    let itemHeight:CGFloat = 230
    
    lazy var discription = ForkDiscriptionView()
    
    func setLayout() {
        self.tableHeaderView = discription
        self.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: discription.height)
        
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 100))
    }
    
    func setAttribute() {
        self.backgroundColor = .Base.light20
        self.separatorStyle = .none
        self.allowsSelection = false
        self.rowHeight = itemHeight
        self.showsVerticalScrollIndicator = false
        
        
        discription.backgroundColor = .white
        discription.navigation = navigation
    }
}
