//
//  RewardCellProvider.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 14/07/2020.
//  Copyright © 2020 Sachin B. All rights reserved.
//


import Foundation
import UIKit

protocol RewardCellProvider {
    func reusableCell(for index: Int) -> RewardCollectionViewCell
    func configure(cell: RewardCollectionViewCell, reward: Reward)
}

class RewardCellProviderImplementation: RewardCellProvider {
    
    let collectionView: UICollectionView
    
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func reusableCell(for index: Int) -> RewardCollectionViewCell {
        return self.rewardCell(for: index)
    }
    
    func configure(cell: RewardCollectionViewCell, reward: Reward) {
        cell.set(reward: reward)
    }
}

fileprivate extension RewardCellProviderImplementation {
    func rewardCell(for item: NSInteger) -> RewardCollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: RewardCollectionViewCell.identifier,
                                                           for: IndexPath.init(item: item, section: 0)) as! RewardCollectionViewCell
        return cell
    }
}
