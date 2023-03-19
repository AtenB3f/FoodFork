//
//  PlateViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/12.
//

import UIKit

class PlateViewController: UIViewController, ViewLayout {
    
    let plateView = PlateView()
    
    let viewModel = PlateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setAttribute()
    }
    
    func setLayout() {
        self.view.addSubview(plateView)
        
        plateView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAttribute() {
        plateView.backgroundColor = .red
    }
}

extension PlateViewController: MTMapViewDelegate {
    
}


#if DEBUG
import SwiftUI

struct PreView: PreviewProvider {
    static var previews: some View {
        PlateViewController().toPreview()
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

