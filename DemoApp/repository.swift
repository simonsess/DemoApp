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
    var stars: Int
    var owner: owner?
    var htmlUrl: String?
    
    var dateModified: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: self.updated ?? ""){
                dateFormatter.dateFormat = "dd-MM-yyyy"
                return dateFormatter.string(from: date)
            } else {
                return "N/A"
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case description = "description"
        case updated = "updated_at"
        case stars = "stargazers_count"
        case owner = "owner"
        case htmlUrl = "html_url"
    }
}

struct owner : Decodable {
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}

struct result: Decodable {
    var repositories: [repository]
    
    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}
