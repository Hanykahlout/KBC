

import UIKit
import WebKit

class WebViewVC: UIViewController {
    
    
    // MARK: - Private Attributes
    
    private var webView: WKWebView!
    private let locationController = LocationController()
    private var url:String = "https://kbc02.com"
    
    
    // MARK: - VC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        locationController.delegate = self
        locationController.checkIfLocationServicesIsEnabled()
    }
    
    
    // MARK: - Private Functions
    private func setUpWebView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        
        webView.customUserAgent = "Chrome"
        
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            if let userAgent = result as? String {
                print("Current User Agent: \(userAgent)")
            }
        }
    }
    
    
    
}


extension WebViewVC:WKNavigationDelegate{}



extension WebViewVC:LocationControllerDelegate{
    
}
