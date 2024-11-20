//
//  AddForkSearchView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/20.
//

import UIKit
import Design

class AddForkSearchView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    func setLayout() {
        addSubview(header)
        addSubview(searchBar)
        addSubview(directInput)
        addSubview(list)

        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(header.height)
        }

        searchBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
            $0.height.equalTo(searchBar.height)
        }

        directInput.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom)
            $0.height.equalTo(directInput.height)
        }

        list.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.top.equalTo(directInput.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }

    func setAttribute() {

    }

    lazy var header = PrevHeaderView(title: "주소 검색(1/4)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })

    lazy var searchBar = AddForkSearchBarView()

    lazy var directInput = AddForkSearchInputView()

    lazy var list = AddForkSearchListView()

    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
            directInput.navigation = navigation
        }
    }

    var viewModel: AddForkSearchViewModel? {
        didSet {
            searchBar.viewModel = viewModel
        }
    }

    var parentViewModel: AddForkViewModel? {
        didSet {
            directInput.parentViewModel = parentViewModel
        }
    }
}
