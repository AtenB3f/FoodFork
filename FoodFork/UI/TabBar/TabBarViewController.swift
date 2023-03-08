//
//  TabBarViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit


class TabBarViewController: UIViewController {
    
    
    lazy var tabBarView = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        delegate = self
        self.view.addSubview(tabBarView)
    }
    
    
}
