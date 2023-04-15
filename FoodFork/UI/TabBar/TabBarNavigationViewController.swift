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
            let addForkVC = AddForkSearchViewController()
            addForkVC.navigation = self
            self.pushViewController(addForkVC, animated: true)
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
