//
//  repoRequest.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import Foundation
import UIKit

enum RepositoryError: Error {
    case noData
    case cannotProcesData
}

struct repoRequest {
    let organisation: String
    let url: URL
    
    init(organisation: String){
        self.organisation = organisation
        let resourceUrlString = "https://api.github.com/orgs/\(organisation)/repos"
        guard let url = URL(string: resourceUrlString) else {fatalError()}
        
        self.url = url
    }
    
    func getRepos (completion: @escaping(Result<[repository], RepositoryError>) -> Void ) {
        let dataTask = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let repoResponse = try decoder.decode([repository].self, from:jsonData)
                completion(.success(repoResponse))
            }catch{
                print(error)
                completion(.failure(.cannotProcesData))
            }
        }
        dataTask.resume()
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
