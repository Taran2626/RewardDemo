//
//  Reward.swift
//  RewardProblem
//
//  Created by Taranjeet Kaur on 23/05/19.
//  Copyright © 2019 Taranjeet Kaur. All rights reserved.
//

import Foundation
import UIKit

enum RewardState: String {
    case unscratched = "UNSCRATCHED"
    case opened = "OPENED"
    case expired = "EXPIRED"
    case none = "NONE"
    
    func getColor() -> UIColor {
        switch self {
        case .unscratched:
            return .red
        case .expired:
            return .gray
        case .opened:
            return .green
        default:
            return .yellow
        }
    }
}

struct Collection: Codable {
    let rewards: [Reward]
}

struct Reward: Codable {
   
    let type: String
    let rewardId: String
    let state: String
    let updatedAt: Int64
    let expiresAt: Int64
    let benefit: Benefit
    
    func getState() -> RewardState {
        return RewardState(rawValue: self.state) ?? .none
    }
}

enum BenefitType: String {
    case offer = "OFFER"
    case coupon = "COUPON"
    case cashBack = "CASHBACK"
    case none = "NONE"
}

struct Benefit: Codable {
    let type: String
    let useBy: Int64
    
    func getType() -> BenefitType {
        return BenefitType(rawValue: self.type) ?? .none
    }
}


