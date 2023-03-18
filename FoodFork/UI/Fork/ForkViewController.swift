//
//  ForkViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit

class ForkViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setAttribute()
    }
    
    lazy var forkView = ForkView()
    
    var viewModel = ForkViewModel()
    
    private func setLayout() {
        self.view.addSubview(forkView)
        
        forkView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    private func setAttribute() {
        self.view.backgroundColor = .white
    }
}
