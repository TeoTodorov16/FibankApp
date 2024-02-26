//
//  PDFViewController.swift
//  FibankApp
//
//  Created by Teo on 24.02.24.
//

import UIKit
import WebKit

class PDFViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscapeLeft, .landscapeRight]
    }

    
    // Declaring pdfURL property to hold the URL of the PDF file
    var pdfURL: URL?
    
    // Adding a custom WKWebView subclass to handle user interactions
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.delegate = self // Setting the scroll view delegate to handle user interactions
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding the WKWebView to the view hierarchy
        view.addSubview(webView)
        
        // Loading the PDF content when the view is loaded
        if let pdfURL = pdfURL {
            webView.load(URLRequest(url: pdfURL))
        }
    }
}

// Implementing UIScrollViewDelegate to handle user interactions
extension PDFViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Resetting the activity timer when scrolling begins
        (presentingViewController as? ViewController)?.resetActivityTimer()
    }
}
