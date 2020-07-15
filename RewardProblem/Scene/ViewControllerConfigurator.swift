//
//  ViewControllerConfigurator.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 14/07/2020.
//  Copyright © 2020 Sachin B. All rights reserved.
//

import UIKit

protocol ViewControllerConfigurator {
    func configure(viewController: ViewController)
}

class ViewControllerConfiguratorImp: ViewControllerConfigurator {
    func configure(viewController: ViewController) {
        let cellProvider = RewardCellProviderImplementation(with: viewController.collectionView)
        let dataProvider = RewardDataProviderImp()
        let presenter = ViewControllerPresenterImp(view: viewController, cellProvider: cellProvider, dataProvider: dataProvider)
        viewController.presenter = presenter
    }
}
