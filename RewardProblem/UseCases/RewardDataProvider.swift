//
//  RewardDataProvider.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 14/07/2020.
//  Copyright © 2020 Taranjeet Kaur. All rights reserved.
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
        return sortUnscratched() + sortOpened(with: .offer) + sortOpened(with: .cashBack) + sortExpired()
    }
    
    private func sortUnscratched() -> [Reward] {
        return rewards.filter { $0.getState() == .unscratched && $0.expiresAt > Date().millisecondsSince1970}.sorted(by: {$0.expiresAt < $1.expiresAt})
    }
    
    private func sortOpened(with type: BenefitType) -> [Reward]{
        
        let rewardOpened = rewards.filter { $0.getState() == .opened && $0.benefit.useBy > Date().millisecondsSince1970 }
        switch type {
        case .offer,.coupon:
            return rewardOpened.filter {($0.benefit.getType() == BenefitType.offer || $0.benefit.getType() == BenefitType.coupon) }
                .sorted(by: {$0.benefit.useBy > $1.benefit.useBy})
        case .cashBack:
            return rewardOpened.filter { $0.getState() == .opened &&
                $0.benefit.getType() == BenefitType.cashBack}
                .sorted(by: {$0.updatedAt > $1.updatedAt})
        case .none:
            return []
        }
    }
    
    private func sortExpired() -> [Reward]{
        return rewards.filter { $0.getState() == .expired || $0.getState() == .unscratched && $0.expiresAt < Date().millisecondsSince1970 || $0.getState() == .opened && $0.benefit.useBy < Date().millisecondsSince1970}.sorted(by: {$0.updatedAt > $1.updatedAt})
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

