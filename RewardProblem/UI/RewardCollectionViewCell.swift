//
//  RewardCollectionViewCell.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 14/07/2020.
//  Copyright © 2020 Sachin B. All rights reserved.
//

import UIKit

protocol RewardCell {
    func set(reward: Reward)
}

final class RewardCollectionViewCell: UICollectionViewCell, RewardCell {
    
    static let identifier = "RewardCollectionViewCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rewardIdLabel: UILabel!
    
    func set(reward: Reward){
        let benefitType = reward.benefit.getType().rawValue
        let rewardExpiry = reward.expiresAt.toDateString() ?? ""
        rewardIdLabel.text = "\(reward.rewardId)\n\(benefitType)\n\(reward.state)\nExpiry:\(rewardExpiry)"
        containerView.backgroundColor = reward.getState().getColor()
    }
}
