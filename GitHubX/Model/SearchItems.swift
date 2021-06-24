//
//  SearchItems.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import Foundation

struct SearchItems: Codable {
    let totalCount: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
