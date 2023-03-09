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
        
        stackView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(60)
        }
        
        for tab in tabs {
            let item = TabBarItemView(type: tab)
            tabItems.append(item)
            stackView.addArrangedSubview(item)
            
            item.snp.makeConstraints { make in
                make.width.equalTo(40)
                make.top.equalToSuperview()
            }
        }
        
        
    }
    
    func setAttribute() {
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
}
