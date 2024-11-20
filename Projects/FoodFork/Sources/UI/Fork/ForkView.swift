//
//  ForkView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit
import Design

class ForkView: UIView, ViewLayout {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    var navigation: NavigationDelegate? {
        didSet {
            list.navigation = navigation
        }
    }

    var viewModel: ForkViewModel?

    lazy var header = HeaderView(title: "포크")

    lazy var list = ForkListView()

    lazy var test: UIButton = {
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = .fontHeader1
        button.addTarget(self, action: #selector(actionTest), for: .touchUpInside)
        return button
    }()

    @objc func actionTest() {
        navigation?.pushNavigation(target: .test)
    }

    func setLayout() {
        self.addSubview(header)
        self.addSubview(list)

        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(header.height)
        }

        list.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }

        // MARK: TEST
//        self.addSubview(test)
//        test.snp.makeConstraints {
//            $0.width.height.equalTo(100)
//            $0.top.equalTo(header.snp.top)
//        }
        // MARK: TEST END
    }

    func setAttribute() {
        list.navigation = navigation
    }
}
