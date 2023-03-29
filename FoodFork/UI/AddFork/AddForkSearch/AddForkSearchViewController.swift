//
//  AddForkSearchViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/20.
//

import UIKit

class AddForkSearchViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setAttribute()
    }
    
    func setLayout() {
        
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

