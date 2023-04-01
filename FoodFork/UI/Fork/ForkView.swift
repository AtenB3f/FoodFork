//
//  ForkView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit

class ForkView: UIView, ViewLayout {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAttribute()
    }
    
    var navigation: NavigationDelegate? = nil {
        didSet {
            list.navigation = navigation
        }
    }
    
    var viewModel: ForkViewModel? = nil
    
    lazy var header = HeaderView(title: "포크")
    
    lazy var list = ForkListView()
    
    func setLayout() {
        self.addSubview(header)
        self.addSubview(list)
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(header.height)
        }
        
        list.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setAttribute() {
        list.navigation = navigation
    }
}
