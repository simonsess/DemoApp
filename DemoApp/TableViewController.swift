//
//  TableViewController.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import UIKit

enum sMode {
    case all
    case org
}

class TableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var defaultSearch: String
    var searchMode: sMode = sMode.org {
        didSet {
            defaultSearch = isOrgSearch ? "apple" : "graphsearch"
            saveButton.isEnabled = isOrgSearch
        }
    }
    var isOrgSearch: Bool{
        get {
            return searchMode == sMode.org
        }
    }
    var searchText: String? {
        get {
            guard var searchText = searchBar.text else {return nil}
            if (searchText.isEmpty) {
                searchText = defaultSearch
            }
            return searchText
        }
    }
    @IBAction func onSaveClick(_ sender: UIBarButtonItem) {
        imageProvider.save()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataSource){
            if let key = searchText {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        searchMode = sMode.org
        defaultSearch = "apple"
        super.init(coder: coder)
    }
    
    var dataSource = [repository]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.placeholder = defaultSearch
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // ---TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepoTableViewCell
        let repo = dataSource[indexPath.row]
        
        cell.titleLabel?.text = repo.fullName
        cell.descLabel?.text = repo.description
        cell.modifyLabel?.text = repo.dateModified
        cell.starsLabel?.text = String(repo.stars)
        guard let avatarUrl = repo.owner?.avatarUrl else { return cell }
            cell.avatarImageView?.downloaded(from:avatarUrl)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
    
    //----TableView-End
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPathForSelectedRow
        guard let row = index?.row else {return}
        let repo = dataSource[row]
        let destVC = segue.destination as! DetailViewController
        destVC.url = repo.htmlUrl
    }
}

extension TableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var searchText = searchBar.text else {return}
        if (searchText.isEmpty) {
            searchText = defaultSearch
        }
        let repoRequest = repoRequest(searchPattern: searchText, search: self.searchMode)
        self.searchBar.resignFirstResponder()
        repoRequest.getRepos {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let repos):
                self?.dataSource = repos
            }
        }
    }
}
