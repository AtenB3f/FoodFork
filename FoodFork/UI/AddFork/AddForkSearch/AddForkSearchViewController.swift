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
    
    lazy var searchView = AddForkSearchView()
    
    func setLayout() {
        self.view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAttribute() {
        self.view.backgroundColor = .green
    }
    
    
}


#if DEBUG
import SwiftUI

struct PreView: PreviewProvider {
    static var previews: some View {
        AddForkSearchViewController().toPreview()
    }
}

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif

