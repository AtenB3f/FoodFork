//
//  TabBarViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit
import SnapKit

class TabBarViewController: UITabBarController {
    
    lazy var tabBarView = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true
        self.view.backgroundColor = .white
        setLayout()
        setAttribute()
    }
    
    func setLayout() {
        
        self.view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(UIDevice.current.notchHeightBottom == 0 ? 60 : UIDevice.current.notchHeightBottom + 44)
        }
    }
    
    func setAttribute() {
        tabBarView.backgroundColor = .Base.disable10
    }
}
