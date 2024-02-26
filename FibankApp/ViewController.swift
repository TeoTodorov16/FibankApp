//
//  PDFViewController.swift
//  FibankApp
//
//  Created by Teo on 24.02.24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscapeLeft, .landscapeRight]
    }

    
    @IBOutlet weak var webView: WKWebView!
    var activityTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self // Setting the view controller as the navigation delegate
        
        // Start the activity timer when the view loads
        startActivityTimer()
                
        // Creating UIImageView
        let backgroundImage = UIImageView(frame: view.bounds)

        // Setting the image
        backgroundImage.image = UIImage(named: "BGFibankApp")

        // Ensuring that the image view resizes with the parent view
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Adding UIImageView to the view
        view.insertSubview(backgroundImage, at: 0)



        // Setting up Auto Layout constraints to cover the entire screen
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
        //
        
        BGTarifa.layer.borderWidth = 0
        BGTarifa.layer.borderColor = UIColor.blue.cgColor
            
        
        BGBuletin.layer.borderWidth = 2
        BGBuletin.layer.borderColor = UIColor.white.cgColor
        BGBuletin.backgroundColor = .clear
        
        
        ENTariffa.layer.borderWidth = 2
        ENTariffa.layer.borderColor = UIColor.white.cgColor
        ENTariffa.backgroundColor = .clear
        
        
        ENBulletin.layer.borderWidth = 0
        ENBulletin.layer.borderColor = UIColor.blue.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // Resetting the activity timer whenever there is user interaction
        resetActivityTimer()
    }
    
    // Method to start the activity timer
    func startActivityTimer() {
        activityTimer = Timer.scheduledTimer(withTimeInterval: 5 * 60, repeats: false) { _ in
            // Reset to the home screen after 5 minutes of inactivity
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Method to reset the activity timer
    func resetActivityTimer() {
        activityTimer?.invalidate()
        startActivityTimer()
    }
    
    @IBOutlet weak var BGTarifa: UIButton!
    @IBOutlet weak var BGBuletin: UIButton!
    @IBOutlet weak var ENTariffa: UIButton!
    @IBOutlet weak var ENBulletin: UIButton!
    
    @IBAction func BGTarifaButtonPressed(_ sender: UIButton) {
        loadPDF(from: "https://www.fibank.bg/web/files/documents/141/files/Tariff.pdf")
    }
    
    @IBAction func BGBuletinButtonPressed(_ sender: UIButton) {
        loadPDF(from: "https://www.fibank.bg/web/files/documents/142/files/Bulletin.pdf")
    }
    
    @IBAction func ENTariffaButtonPressed(_ sender: UIButton) {
        loadPDF(from: "https://www.fibank.bg/web/files/documents/203/files/Tariff_EN.pdf")
    }
    
    @IBAction func ENBulletinButtonPressed(_ sender: UIButton) {
        loadPDF(from: "https://www.fibank.bg/web/files/documents/204/files/Bulletin_EN.pdf")
    }
    
    func loadPDF(from urlString: String) {
        guard let pdfURL = URL(string: urlString) else {
            return
        }
        
        let pdfViewController = PDFViewController()
        pdfViewController.pdfURL = pdfURL
        
        // Setting the "Back" button title
        pdfViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back to Home", style: .plain, target: self, action: #selector(backToHome))
        
        let navController = UINavigationController(rootViewController: pdfViewController)
        present(navController, animated: true, completion: nil)
        
        // Resetting the activity timer when a PDF is loaded
        resetActivityTimer()
    }
    
    @objc func backToHome() {
        dismiss(animated: true, completion: nil)
    }
}
