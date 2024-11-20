//
//  UIApplication+.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/14/24.
//

import UIKit

extension UIApplication {

    var firstViewController: UIViewController? {
        return findAllViewControllers().first
    }

    var lastViewController: UIViewController? {
        return findAllViewControllers().last
    }

    func findAllViewControllers() -> [UIViewController] {
        var allViewControllers: [UIViewController] = []

        // 재귀적으로 모든 뷰 컨트롤러를 탐색
        func findControllers(from viewController: UIViewController) {
            allViewControllers.append(viewController)

            if let navigationController = viewController as? UINavigationController {
                for childViewController in navigationController.viewControllers {
                    findControllers(from: childViewController)
                }
            }

            if let tabBarController = viewController as? UITabBarController {
                if let selectedViewController = tabBarController.selectedViewController {
                    findControllers(from: selectedViewController)
                }
            }

            if let presentedViewController = viewController.presentedViewController {
                findControllers(from: presentedViewController)
            }
        }

        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            findControllers(from: rootViewController)
        }

        return allViewControllers
    }

    func debugAllViewController() {
        if UIApplication.shared.keyWindow?.rootViewController != nil {

            var allView = findAllViewControllers()
            for view in allView {
                print(view)
            }
        }
    }

}
