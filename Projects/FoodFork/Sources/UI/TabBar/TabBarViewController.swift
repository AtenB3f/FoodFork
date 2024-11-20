//
//  TabBarViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit
import SnapKit
import RxSwift

class TabBarViewController: UITabBarController {

    lazy var tabBarView = TabBarView()

    lazy var forkViewController = ForkViewController()
    lazy var plateViewController = PlateViewController()

    var viewModel = TabBarViewModel()

    private var disposeBag = DisposeBag()

    var navigation: NavigationDelegate? {
        didSet {
            forkViewController.navigation = navigation
            plateViewController.navigation = navigation
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarView.viewModel = viewModel

        setLayout()
        setAttribute()
        setBind()
    }

    private func setLayout() {

        self.view.addSubview(tabBarView)

        tabBarView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(UIView.tabbarHeight)
        }
    }

    private func setAttribute() {
        self.tabBar.isHidden = true
        self.view.backgroundColor = .white

        tabBarView.backgroundColor = .Base.medium30
        self.viewControllers = [forkViewController, plateViewController]
    }

    private func setBind() {

        let input = TabBarViewModel.Input(tab: viewModel.selectedTab.asDriver())

        let output = viewModel.transform(input: input)

        output.selectedTab
            .map { $0 }
            .drive(onNext: { type in
                self.changeTab(type)
            })
            .disposed(by: disposeBag)
    }

    private func changeTab(_ tabType: TabBarType) {
        self.selectedIndex = tabType.rawValue
        if let tab = tabBarView.tabItems.first(where: { $0.type == tabType }) {
            tab.select(true)
        }
    }
}
