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
    
    var viewModel: ForkViewModel? = nil
    
    private lazy var header = HeaderView(title: "포크")
    
    private lazy var scroll = UIScrollView()
    
    private lazy var discription = ForkDiscriptionView()
    
    private lazy var list = ForkListView()
    
    func setLayout() {
        self.addSubview(header)
        self.addSubview(scroll)
        scroll.addSubview(discription)
        scroll.addSubview(list)
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(header.height)
        }
        
        scroll.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        discription.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(discription.height)
        }
        
        list.snp.makeConstraints { make in
            make.top.equalTo(discription.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setAttribute() {
        discription.backgroundColor = .white
    }
}
