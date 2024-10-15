//
//  AddForkStarRateViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit

class AddForkStarRateViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setLayout()
        setAttribute()
        setNotification()
    }

    func setLayout() {
        
        self.view.addSubview(rateView)
        
        rateView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    func setAttribute() {
        self.view.backgroundColor = .white
        rateView.viewModel = viewModel
        
        let gesturePan = UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:)))
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        rateView.addGestureRecognizer(gesturePan)
        rateView.addGestureRecognizer(gestureTap)
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView),name: .reloadView, object: nil)
    }

    var navigation: NavigationDelegate? {
        didSet {
            rateView.navigation = navigation
        }
    }

    lazy var rateView =  AddForkStarRateView()
    
    var viewModel = AddForkStarRateViewModel()
    
    @objc func reloadView(){
        self.reloadInputViews()
    }
    
    @objc func panHandler(_ sender: UIPanGestureRecognizer) {
        rateView.star.panHandler(sender)
//        self.reloadView()
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        rateView.star.tapHandler(sender)
//        self.reloadView()
    }
}
