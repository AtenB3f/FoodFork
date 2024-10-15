//
//  AddForkViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/8/24.
//


import UIKit

class AddForkViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setLayout()
        setAttribute()
    }

    func setLayout() {
        
        self.view.addSubview(addressView)
        
        addressView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    func setAttribute() {
        self.view.backgroundColor = .white
    }

    var navigation: NavigationDelegate? {
        didSet {
            addressView.navigation = navigation
        }
    }

    lazy var addressView =  AddForkAddressView()
    

    var viewModel = AddForkViewModel()
    
}
