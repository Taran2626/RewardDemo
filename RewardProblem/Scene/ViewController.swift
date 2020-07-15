//
//  ViewController.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 22/05/19.
//  Copyright © 2019 Taranjeet Kaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MainView {
    
    var configurator: ViewControllerConfigurator! = ViewControllerConfiguratorImp()
    var presenter: ViewControllerPresenter!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let cellPerPage: CGFloat = CGFloat(2)
            let spacing = (cellPerPage + 1) * 8
            let cellWidth: CGFloat = (UIScreen.main.bounds.size.width - spacing) / cellPerPage
            if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                collectionViewLayout.minimumLineSpacing = 8
                collectionViewLayout.minimumInteritemSpacing = 4
                collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(viewController: self)
        self.presenter.viewDidLoad()
    }
    
    func reload(){
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.presenter.reusableCell(for: indexPath.item)
        self.presenter.configure(cell: cell, at: indexPath.item)
        return cell
    }
}

extension Int64 {
    func toDateString() -> String? {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-YY" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
}
