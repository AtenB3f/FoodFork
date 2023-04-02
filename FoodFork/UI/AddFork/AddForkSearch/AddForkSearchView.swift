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
        addSubview(searchBar)
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(header.height)
        }
        
        searchBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
            $0.height.equalTo(searchBar.height)
        }
    }
    
    func setAttribute() {
        
    }
    
    lazy var header = PrevHeaderView(title: "포크 추가(1/3)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    
    lazy var searchBar = AddForkSearchBarView()
    
    var navigation: NavigationDelegate? = nil {
        didSet {
            // subView navigatin link
        }
    }
}
