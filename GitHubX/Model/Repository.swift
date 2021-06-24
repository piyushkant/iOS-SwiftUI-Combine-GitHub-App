//
//  Repository.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "html_url"
    }
}
