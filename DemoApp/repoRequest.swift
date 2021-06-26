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
    let searchString: String
    var url: URL
    var searchMode: sMode
    let orgUrlString = "https://api.github.com/orgs/%@/repos"
    let allRepoUrlString = "https://api.github.com/search/repositories?q=%@"
    
    var isOrgSearch: Bool {
        get {
            return searchMode == sMode.org
        }
    }
    
    init(searchPattern: String, search: sMode){
        self.searchString = searchPattern
        self.searchMode = search
        let formatUrl = searchMode == sMode.org ? orgUrlString : allRepoUrlString
        let resourceUrlString = String(format: formatUrl, self.searchString)
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
                if(isOrgSearch) {
                    let repoResponse = try decoder.decode([repository].self, from:jsonData)
                    completion(.success(repoResponse))
                } else {
                    let repoResponse = try decoder.decode(result.self, from: jsonData)
                    completion(.success(repoResponse.repositories))
                }
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
                imageProvider.set(value: image, key: url.absoluteString)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
