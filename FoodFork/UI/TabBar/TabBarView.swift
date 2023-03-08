//
//  TabBarView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit



class TabBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tabs:[TabBarType] = [.fork, .plate, .my]
    var tabItems: [TabBarItemView] = []
    
    let stackView: UIStackView = {
        let view = UIStackView()
        
        view.distribution = .equalSpacing
        view.axis = .horizontal
        
        return view
    }()
    
    func setLayout() {
        self.addSubview(stackView)
        
        for tab in tabs {
            let item = TabBarItemView(type: tab)
            tabItems.append(item)
            stackView.addArrangedSubview(item)
        }
    }
    
    func setAttribute() {
        
    }
    
}
