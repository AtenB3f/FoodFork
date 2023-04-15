//
//  ForkViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit

class ForkViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
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

        self.forkView.list.delegate = self
        self.forkView.list.dataSource = self
        self.forkView.list.register(ForkItemView.self, forCellReuseIdentifier: ForkItemView.id)
    }
}

extension ForkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.forkInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = forkView.list.dequeueReusableCell(withIdentifier: ForkItemView.id, for: indexPath) as? ForkItemView else {
            return UITableViewCell()
        }

        cell.index = indexPath.row
        cell.setData(viewModel.forkInfo[indexPath.row])

        return cell
    }

//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

// #if DEBUG
// import SwiftUI
//
// struct PreView: PreviewProvider {
//    static var previews: some View {
//        ForkViewController().toPreview()
//    }
// }
//
// extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//        
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//        
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//    
//    func toPreview() -> some View {
//        Preview(viewController: self)
//    }
// }
// #endif
//
