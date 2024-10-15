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
        
    }
    
    func setAttribute() {
        
    }
    
    
    private lazy var header = PrevHeaderView(callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    private lazy var delete: UIButton =  {
        let button = UIButton()

        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.Text.dark40, for: .normal)
        button.addTarget(self, action: #selector(deleteFork), for: .touchUpInside)

        return button
    }()
    
    private lazy var picture = UIScrollView()
    private lazy var contents = UIView()
    private lazy var store = UITextView()
    private lazy var rate = StarRateLabel()
    private lazy var reviews = UITextView()
    private lazy var map = UIView()
    
    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
            
        }
    }
    
    @objc func deleteFork() {
        
    }
}


