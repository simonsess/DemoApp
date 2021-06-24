//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Simon Skalicky on 24/06/2021.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var detailWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var url: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        detailWebView.isHidden = false
        activityIndicator.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailWebView.navigationDelegate = self
        
        detailWebView.isHidden = true
        activityIndicator.isHidden = false
        
        activityIndicator.startAnimating()
        
        detailWebView.contentMode = .scaleToFill
        // Do any additional setup after loading the view.
        guard let url = URL(string: url ?? "") else {return}
        let request = URLRequest(url: url)
        detailWebView.load(request)
    }
}
