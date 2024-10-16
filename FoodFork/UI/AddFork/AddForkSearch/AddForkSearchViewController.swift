//
//  AddForkSearchViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/20.
//

import UIKit
import SnapKit

class AddForkSearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
    }

    func setLayout() {
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setAttribute() {
        self.view.backgroundColor = .white
        
        self.searchView.list.delegate = self
        self.searchView.list.dataSource = self
        self.searchView.list.register(AddForkSearchItemView.self, forCellReuseIdentifier: AddForkSearchItemView.id)
        
        searchView.viewModel = viewModel
        searchView.parentViewModel = parentViewModel
    }

    var navigation: NavigationDelegate? {
        didSet {
            searchView.navigation = navigation
        }
    }

    lazy var searchView = AddForkSearchView()

    var viewModel = AddForkSearchViewModel()
    var parentViewModel: AddForkViewModel?
}

extension AddForkSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.storeInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchView.list.dequeueReusableCell(withIdentifier: AddForkSearchItemView.id, for: indexPath) as? AddForkSearchItemView else {
            return UITableViewCell()
        }

        cell.index = indexPath.row
        cell.setData(viewModel.storeInfo[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: TEST
        
        let info = viewModel.storeInfo[indexPath.row]
        print(info)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        parentViewModel?.setForkInfo(storeName: info.storeName, address: info.address)
        
        // 페이지 이동
        navigation?.pushNavigation(target: .addForkPicture(parentViewModel: parentViewModel ?? AddForkViewModel()))
    }
}
