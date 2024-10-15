//
//  TabBarNavigationViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/01.
//

import Foundation

class TabBarNavigationViewController: UINavigationController, ViewLayout {

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

        case .addFork:
            let vc = AddForkSearchViewController()
            vc.navigation = self
            self.pushViewController(vc, animated: true)
            
        case .test:
            let vc = AddForkStarRateViewController()
            vc.navigation = self
            
            self.pushViewController(vc, animated: true)
            
        case .addForkSearch:
            let vc = AddForkSearchViewController()
            vc.navigation = self
            self.pushViewController(vc, animated: true)
            
        case .addForkInputAddress:
            let vc = AddForkAddressViewController()
            vc.navigation = self
            self.pushViewController(vc, animated: true)
            
        case .addForkPicture:
            let vc = AddForkPictureViewController()
            vc.navigation = self
            self.pushViewController(vc, animated: true)
            
        case .addForkStar:
            let vc = AddForkAddressViewController()
            vc.navigation = self
            self.pushViewController(vc, animated: true)
            
        case .addForkReview:
            let vc = AddForkReviewViewController()
            vc.navigation = self
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
}
