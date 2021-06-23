//
//  Repository.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import Foundation

struct repository: Decodable {
    var fullName: String?
    var description: String?
    var updated: String? //"2021-06-20T11:20:22Z"
    var stars: Int?
    var owner: owner?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case description = "description"
        case updated = "updated_at"
        case stars = "stargazers_count"
        case owner = "owner"
    }
}

struct owner : Decodable {
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}
