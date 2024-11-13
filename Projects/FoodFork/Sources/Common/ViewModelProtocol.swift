//
//  ViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/11.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
