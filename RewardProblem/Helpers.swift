//
//  Helpers.swift
//  RewardProblem
//
//  Created by Sachin B on 23/05/19.
//  Copyright © 2019 Sachin B. All rights reserved.
//

import Foundation

enum Page: String, CaseIterable {
    case offers = "offers"
    case coupon = "coupon"
    case cashback = "cashback"
}

class Helper {
    
    static func getData() throws -> [Reward] {
        var rewardCollection: [Reward] = []
        for page in Page.allCases {
            do {
                let result = try Collection.fromJSON(page.rawValue) as Collection
                rewardCollection.append(contentsOf: result.rewards)
            } catch {
                throw NSError(domain: "Invalid Data", code: 303)
            }
        }
        return rewardCollection
    }
}

extension Decodable {
    static func fromJSON<T:Decodable>(_ fileName: String, fileExtension: String="json", bundle: Bundle = .main) throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorResourceUnavailable)
        }
        let data = try Data(contentsOf: url)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw NSError(domain: "Invalid Data", code: 303)
        }
    }
}
