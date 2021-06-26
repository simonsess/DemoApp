//
//  ViewController.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import UIKit

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TableViewController
        
        switch segue.identifier {
            case "org":
                destVC.searchMode = sMode.org
                destVC.navigationItem.title = "Organisation"
            case "all":
                destVC.searchMode = sMode.all
                destVC.navigationItem.title = "All Repositories"
            default:
                destVC.searchMode = sMode.all
        }
    }

}

