//
//  Repsitory.swift
//  gitHubRepository
//
//  Created by 김성준 on 2022/07/25.
//

import Foundation

struct Repsitory: Decodable {
    let id: Int
    let name: String
    let description: String
    let stargazersCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey{
        case id, name, description, language
        case stargazersCount = "stargazers_count"
    }
}
