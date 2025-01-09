//
//  TabBarNavigationViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/01.
//

import UIKit
import Design

class TestViewController: UIViewController {

    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "초기세팅 테스트 입니다."
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.clipsToBounds = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }

    private func setUI() {
        view.addSubview(testLabel)
        view.backgroundColor = .yellow
    }

    private func setLayout() {
        testLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
    }
}

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
            let controller = AddForkReviewViewController()
            controller.navigation = self

            self.pushViewController(controller, animated: true)

        case .addFork:
            let viewModel = AddForkViewModel()
            pushNavigation(target: .addForkSearch(parentViewModel: viewModel))

        case .addForkSearch(let viewModel):
            let controller = AddForkSearchViewController()
            controller.navigation = self
            controller.parentViewModel = viewModel
            node.append(controller)
            self.pushViewController(controller, animated: true)

        case .addForkInputAddress(let viewModel):
            let controller = AddForkAddressViewController()
            controller.navigation = self
            controller.parentViewModel = viewModel
            self.pushViewController(controller, animated: true)

        case .addForkPicture(let viewModel):
            let controller = AddForkPictureViewController()
            controller.navigation = self
            controller.parentViewModel = viewModel
            self.pushViewController(controller, animated: true)

        case .addForkStar(let viewModel):
            let controller = AddForkStarRateViewController()
            controller.navigation = self
            controller.parentViewModel = viewModel
            self.pushViewController(controller, animated: true)

        case .addForkReview(let viewModel):
            let controller = AddForkReviewViewController()
            controller.navigation = self
            controller.parentViewModel = viewModel
            self.pushViewController(controller, animated: true)

        case .detailFork(let forkInfo):
            let controller = ForkDetailViewController()
            controller.navigation = self
            controller.viewModel.forkInfo = forkInfo
            self.pushViewController(controller, animated: true)
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
