//
//  ForkDetailView.swift
//  FoodFork
//
//  Created by Ivy Moon on 9/17/24.
//

import UIKit

class ForkDetailView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }
    
    func setLayout() {
        [header, delete, scroll].forEach { self.addSubview($0) }
        scroll.addSubview(contents)
        
        header.snp.makeConstraints {
            $0.left.right.width.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(header.height)
        }
        
        delete.snp.makeConstraints {
            $0.centerY.equalTo(header.snp.centerY)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        
        scroll.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.left.right.width.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        contents.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
    }
    
    func setAttribute() {
        
    }
    
    var viewModel: ForkDetailViewModel? {
        didSet {
            contents.viewModel = viewModel
        }
    }
    
    lazy var header = PrevHeaderView(callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    
    lazy var delete: UIButton =  {
        let button = UIButton()

        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.Text.dark40, for: .normal)
        button.addTarget(self, action: #selector(deleteFork), for: .touchUpInside)

        return button
    }()
    
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = false
        return scroll
    }()
    
    lazy var contents = ForkDetailContentView()
    
    
    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
            
        }
    }
    
    @objc func deleteFork() {
        
    }
}


