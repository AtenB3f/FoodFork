//
//  TabBarNavigationViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/01.
//

import UIKit

class TabBarNavigationViewController: UINavigationController, ViewLayout {
    
    var node: [UIViewController] = []

    lazy var tabBar = TabBarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
        pushNavigation(target: .root)
    }

    func setLayout() {
    }

    func setAttribute() {
        tabBar.navigation = self
        self.isNavigationBarHidden = true
    }
}

extension TabBarNavigationViewController: NavigationDelegate {
    func pushNavigation(target: NavigationTarget) {
        switch target {
        case .root:
            self.pushViewController(tabBar, animated: true)
            
        case .test:
            let vc = AddForkStarRateViewController()
            vc.navigation = self
            
            self.pushViewController(vc, animated: true)
            
        case .addFork:
            let viewModel = AddForkViewModel()
            pushNavigation(target: .addForkSearch(parentViewModel: viewModel))
            
        case .addForkSearch(let viewModel):
            let vc = AddForkSearchViewController()
            vc.navigation = self
            vc.parentViewModel = viewModel
            node.append(vc)
            self.pushViewController(vc, animated: true)
            
        case .addForkInputAddress(let viewModel):
            let vc = AddForkAddressViewController()
            vc.navigation = self
            vc.parentViewModel = viewModel
            self.pushViewController(vc, animated: true)
            
        case .addForkPicture(let viewModel):
            let vc = AddForkPictureViewController()
            vc.navigation = self
            vc.parentViewModel = viewModel
            self.pushViewController(vc, animated: true)
            
        case .addForkStar(let viewModel):
            let vc = AddForkAddressViewController()
            vc.navigation = self
            vc.parentViewModel = viewModel
            self.pushViewController(vc, animated: true)
            
        case .addForkReview(let viewModel):
            let vc = AddForkReviewViewController()
            vc.navigation = self
            vc.parentViewModel = viewModel
            self.pushViewController(vc, animated: true)
        }
    }

    func popNavigation(isRoot: Bool = false) {
        if isRoot {
            let root = self.viewControllers[0]
            self.popToViewController(root, animated: true)
        } else {
            self.popViewController(animated: true)
        }
    }
    
    func popNavigation(isLastNode: Bool = false) {
        if isLastNode {
            if let node = self.node.last {
                self.popToViewController(node, animated: true)
                self.node.removeLast()
            }
        } else {
            self.popViewController(animated: true)
        }
    }
}
