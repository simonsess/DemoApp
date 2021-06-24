//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Simon Skalicky on 24/06/2021.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailWebView: WKWebView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBAction func onDoneClick(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailWebView.contentMode = .scaleToFill
        // Do any additional setup after loading the view.
        guard let url = URL(string: url ?? "") else {return}
        let request = URLRequest(url: url)
        detailWebView.load(request)
    }
}
