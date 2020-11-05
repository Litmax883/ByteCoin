//
//  BitModel.swift
//  ByteCoin
//
//  Created by MAC on 04.11.2020.
//  Copyright © 2020 Litmax. All rights reserved.
//

import Foundation

struct BitModel: Codable {
    let assetIDBase: String
    let rates: [Rate]
    
    enum CodingKeys: String, CodingKey {
        case assetIDBase = "asset_id_base"
        case rates
    }
}

// MARK: - Rate
struct Rate: Codable {
    let time, assetIDQuote: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}


