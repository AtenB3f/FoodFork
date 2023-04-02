//
//  AddForkSearchItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/02.
//

import UIKit

class AddForkSearchItemView: UIView, ViewLayout {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        
    }
    
    func setAttribute() {
        
    }
    
    var navigation: NavigationDelegate? = nil {
        didSet {
            // subView navigatin link
        }
    }
}
