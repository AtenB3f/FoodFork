//
//  TabBarView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit
import RxSwift

class TabBarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewModel: TabBarViewModel? {
        didSet {
            if self.viewModel != nil {
                self.initialize()
            }
        }
    }
    
    var tabItems: [TabBarItemView] = []

    let stackView: UIStackView = {
        let view = UIStackView()

        view.distribution = .equalSpacing
        view.axis = .horizontal

        return view
    }()
    
    func initialize() {
        setLayout()
        setAttribute()
    }

    func setLayout() {
        self.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(80)
        }

        for tab in viewModel?.tabs ?? [] {
            let item = TabBarItemView(type: tab)
            tabItems.append(item)
            stackView.addArrangedSubview(item)

            item.snp.makeConstraints { make in
                make.width.equalTo(40)
                make.top.equalToSuperview()
            }
        }
    }

    func setAttribute() {
        stackView.isLayoutMarginsRelativeArrangement = true

        for tab in tabItems {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(selectTab(_:)))

            tab.addGestureRecognizer(gesture)        }
    }

    @objc func selectTab(_ sender: UITapGestureRecognizer) {
        guard let index = viewModel?.selectedTab.value.rawValue else { return }
        guard tabItems.count > index else { return }

        tabItems[index].select(false)

        for tabItem in tabItems {
            if let first = tabItem.gestureRecognizers?.first {
                if first == sender {
                    viewModel?.selectedTab.accept(tabItem.type ?? .fork)
                    tabItem.select(true)
                }
            }
        }
    }
}
