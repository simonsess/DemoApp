//
//  Repository.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import Foundation
import UIKit

class imageProvider {
    //TODO encapsulate to call online and offline images
    static var images: [String: UIImage] = [:]
    static func addData(key: String, image: UIImage) {
        
    }
    
    static func hasKey(key: String) -> Bool {
        return images[key] != nil
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: "images")
    }
    
    static func get(key: String) -> UIImage? {
        if (hasKey(key: key)) {
            return images[key]
        }
        return nil
    }
    
    static func set(value: UIImage, key: String) {
        if (hasKey(key: key)) {
            return
        }
                
        images[key] = value
    }
    
    static func save() {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: images, requiringSecureCoding: false) as Data
        else { fatalError("Can't save images.") }
        
        UserDefaults.standard.setValue(data, forKey: "images")
    }
    
    static func load() {
        if let data = UserDefaults.standard.value(forKey: "images") as? Data{
//            guard let images = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [String: UIImage], from: data) as! [String: UIImage]
            guard let images = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: UIImage]
            else { fatalError("Can't load images.") }
            
            self.images = images
        }
    }
}

struct repository: Codable {
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(description, forKey: .description)
        try container.encode(updated, forKey: .updated)
        try container.encode(stars, forKey: .stars)
        try container.encode(owner, forKey: .owner)
        try container.encode(htmlUrl, forKey: .htmlUrl)

    }
}

struct owner : Codable {
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(avatarUrl, forKey: .avatarUrl)
    }
}

struct result: Decodable {
    var repositories: [repository]
    
    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}
