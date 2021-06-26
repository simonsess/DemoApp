//
//  databaseTableViewController.swift
//  DemoApp
//
//  Created by Simon Skalicky on 26/06/2021.
//

import Foundation
import UIKit

class databaseTableViewController: UITableViewController {

    var dataSource = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = Array(UserDefaults.standard.dictionaryRepresentation().keys)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteHandler: UIContextualAction.Handler = { [self] action, view, completion in
            UserDefaults.standard.removeObject(forKey: self.dataSource[indexPath.row])
            self.dataSource.remove(at: indexPath.row)
            tableView.reloadData()
            completion(true)
          }
        
        let delete = UIContextualAction(style: .destructive, title: "Detele", handler: deleteHandler)
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
