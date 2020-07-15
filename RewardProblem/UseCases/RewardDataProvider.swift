//
//  RewardDataProvider.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 14/07/2020.
//  Copyright © 2020 Sachin B. All rights reserved.
//

import UIKit

protocol RewardDataProvider {
    func item(atIndex index: Int) -> Reward
    func numberOfItems() -> Int
    func sortRewards() -> [Reward]
   
}

class RewardDataProviderImp: RewardDataProvider {

    var rewards: [Reward] = []
    
    init() {
        if let data = try? Helper.getData() {
            
            self.rewards = data
            self.rewards = sortRewards()
        }
    }
    
    func sortRewards() -> [Reward] {
                
        let unscratched = rewards.filter { $0.getState() == .unscratched && $0.expiresAt > Date().millisecondsSince1970}.sorted(by: {$0.expiresAt < $1.expiresAt})
        
        let openedOffernCoupon = rewards.filter { $0.getState() == .opened &&
            ($0.benefit.getType() == BenefitType.offer || $0.benefit.getType() == BenefitType.coupon) &&
            $0.benefit.useBy > Date().millisecondsSince1970
        }.sorted(by: {$0.benefit.useBy > $1.benefit.useBy})
        
        let openedCashback = rewards.filter { $0.getState() == .opened &&
            $0.benefit.getType() == BenefitType.cashBack &&
            $0.benefit.useBy > Date().millisecondsSince1970}
            .sorted(by: {$0.updatedAt > $1.updatedAt})
        
        let expired = rewards.filter { $0.getState() == .expired || $0.getState() == .unscratched && $0.expiresAt < Date().millisecondsSince1970 || $0.getState() == .opened && $0.benefit.useBy < Date().millisecondsSince1970}.sorted(by: {$0.updatedAt > $1.updatedAt})

        return unscratched + openedOffernCoupon + openedCashback + expired
    }
    
    func numberOfItems() -> Int{
        return rewards.count
    }
    
    func item(atIndex index: Int) -> Reward{
        return rewards[index]
    }

    
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

