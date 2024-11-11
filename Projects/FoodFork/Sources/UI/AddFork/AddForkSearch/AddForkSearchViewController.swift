//
//  AddForkSearchViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AddForkSearchViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
        setBind()
    }

    func setLayout() {
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setAttribute() {
        self.view.backgroundColor = .white
        
        self.searchView.list.register(AddForkSearchItemView.self, forCellReuseIdentifier: AddForkSearchItemView.id)
        
        searchView.viewModel = viewModel
        searchView.parentViewModel = parentViewModel
    }
    
    func setBind() {
        viewModel.storeInfo
            .bind(to: searchView.list.rx.items(cellIdentifier: AddForkSearchItemView.id, cellType: AddForkSearchItemView.self)) { _, data, cell in
                cell.setData(data)
            }
            .disposed(by: disposeBag)
        
        searchView.list.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                guard let self = self else { return }
                
                let info = viewModel.storeInfo.value[indexPath.row]
                searchView.list.deselectRow(at: indexPath, animated: true)
                parentViewModel?.setForkInfo(storeName: info.placeName, category: info.category, x:info.x, y:info.y, address: info.address)
                navigation?.pushNavigation(target: .addForkPicture(parentViewModel: parentViewModel ?? AddForkViewModel()))
            })
            .disposed(by: disposeBag)
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
