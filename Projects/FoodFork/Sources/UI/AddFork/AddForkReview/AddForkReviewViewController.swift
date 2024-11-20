//
//  AddForkReviewViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit

class AddForkReviewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
        setNotification()
    }

    func setLayout() {

        self.view.addSubview(reviewView)

        reviewView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

    func setAttribute() {
        self.view.backgroundColor = .white

        reviewView.viewModel = viewModel
        reviewView.parentViewModel = parentViewModel
    }

    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: .reloadView, object: nil)
    }

    var navigation: NavigationDelegate? {
        didSet {
            reviewView.navigation = navigation
        }
    }

    lazy var reviewView =  AddForkReviewView()

    var viewModel = AddForkReviewViewModel()
    var parentViewModel: AddForkViewModel?

    @objc func reloadView() {
        self.reloadInputViews()
    }
}
