//
//  AddForkAddressViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit

class AddForkAddressViewController: UIViewController {
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

        addressView.viewModel = viewModel
        addressView.parentViewModel = parentViewModel
    }

    var navigation: NavigationDelegate? {
        didSet {
            addressView.navigation = navigation
        }
    }

    lazy var addressView =  AddForkAddressView()

    var viewModel = AddForkAddressViewModel()
    var parentViewModel: AddForkViewModel?
}
