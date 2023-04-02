//
//  AddForkSearchView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/20.
//

import UIKit

class AddForkSearchView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAttribute()
    }
    
    func setLayout() {
        addSubview(header)
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(header.height)
        }
    }
    
    func setAttribute() {
        
    }
    
    lazy var header = PrevHeaderView(title: "포크 추가(1/3)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    
    var navigation: NavigationDelegate? = nil {
        didSet {
            // subView navigatin link
        }
    }
}
