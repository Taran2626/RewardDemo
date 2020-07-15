//
//  ViewControllerPresenter.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 14/07/2020.
//  Copyright © 2020 Sachin B. All rights reserved.
//

import UIKit

protocol MainView: class {
    func reload()
}

protocol ViewControllerPresenter {
    /// Returns the number of items for collection view.
    var numberOfItems: Int { get }
    /// This method is to get the reuseable cell for collection view.
    func reusableCell(for index: Int) -> RewardCollectionViewCell
    /// This method is to configure the cell.
    func configure(cell: RewardCollectionViewCell, at index: Int)
    /// Method to be called once the view is loaded.
    func viewDidLoad()

}

class ViewControllerPresenterImp: ViewControllerPresenter {
    
    private weak var view: MainView?
    fileprivate var cellProvider: RewardCellProvider
    fileprivate var dataProvider: RewardDataProvider
    
    init(view: MainView, cellProvider: RewardCellProvider, dataProvider: RewardDataProvider) {
        self.view = view
        self.cellProvider = cellProvider
        self.dataProvider = dataProvider
    }
    
    var numberOfItems: Int {
        return dataProvider.numberOfItems()
    }
    
    func reusableCell(for index: Int) -> RewardCollectionViewCell {
        return cellProvider.reusableCell(for: index)
    }
    
    func configure(cell: RewardCollectionViewCell, at index: Int) {
        let reward = dataProvider.item(atIndex: index)
        cellProvider.configure(cell: cell, reward: reward)
    }
    
    func viewDidLoad() {
    }
    

}
