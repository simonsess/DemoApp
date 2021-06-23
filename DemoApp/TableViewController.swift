//
//  TableViewController.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataSource = [repository]() {
        didSet {
            DispatchQueue.main.async {
                //reload data
                self.tableView.reloadData()
                
            }
        }
    }
   // let organization = "apple"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "apple"
        
        let nib = UINib(nibName: "RepoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RepoTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell",
                                                 for: indexPath) as! RepoTableViewCell
        let repo = dataSource[indexPath.row]
        
        cell.titleLabel?.text = repo.fullName
        cell.descLabel?.text = repo.description
        cell.modifyLabel?.text = repo.updated
        guard let avatarUrl = repo.owner?.avatarUrl else { return cell }
            cell.avatarImageView?.downloaded(from:avatarUrl)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
    
    //----TableView-End
}

extension TableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let orgName = searchBar.text else {return}
        let repoRequest = repoRequest(organisation: orgName)
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
