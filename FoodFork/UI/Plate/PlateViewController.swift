//
//  PlateViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/12.
//

import UIKit

class PlateViewController: UINavigationController, ViewLayout {

    let plateView = PlateView()

    let viewModel = PlateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
    }

    func setLayout() {
        self.view = plateView
    }

    func setAttribute() {
        plateView.backgroundColor = .red
    }
}
