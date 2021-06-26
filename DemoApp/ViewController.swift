//
//  ViewController.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import UIKit

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier {
            case "org":
                let destVC = segue.destination as! TableViewController
                destVC.searchMode = sMode.org
                destVC.navigationItem.title = "Organisation"
            case "all":
                let destVC = segue.destination as! TableViewController
                destVC.searchMode = sMode.all
                destVC.navigationItem.title = "All Repositories"
            case "database":
                let destVC = segue.destination as! databaseTableViewController
                destVC.navigationItem.title = "DataBase"
            default:
                let destVC = segue.destination
                destVC.navigationItem.title = "default"
        }
    }

}

