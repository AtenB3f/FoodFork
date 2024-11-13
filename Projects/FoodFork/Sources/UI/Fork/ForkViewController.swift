//
//  ForkViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit
import RxSwift
import RxCocoa
import Data

class ForkViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
        setBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFork()
        forkView.list.reloadData()
    }
    
    lazy var forkView = ForkView()

    var viewModel = ForkViewModel()

    var navigation: NavigationDelegate? {
        didSet {
            forkView.navigation = navigation
        }
    }

    private func setLayout() {
        self.view = forkView
    }

    private func setAttribute() {
        self.view.backgroundColor = .white
        
        self.forkView.list.register(ForkItemView.self, forCellReuseIdentifier: ForkItemView.id)
    }
    
    func setBind() {
        viewModel.forkInfo
            .bind(to: forkView.list.rx.items(cellIdentifier: ForkItemView.id, cellType: ForkItemView.self)) { _, data, cell in
                cell.setData(data)
            }
            .disposed(by: disposeBag)
        
        forkView.list.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                guard let self = self else { return }
                
                let info = viewModel.forkInfo.value[indexPath.row]
                self.forkView.list.deselectRow(at: indexPath, animated: true)
                navigation?.pushNavigation(target: .detailFork(forkInfo: info))
            })
            .disposed(by: disposeBag)
    }
}
