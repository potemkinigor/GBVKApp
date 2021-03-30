//
//  AutorizeViewController.swift
//  VKApp
//
//  Created by User on 21.03.2021.
//

import UIKit
import WebKit

class AutorizeViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7797504"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        
        webview.load(request)
    }

}

extension AutorizeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let parameters = fragment
            .components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String : String]()) { result, parameter in
                var dict = result
                let key = parameter[0]
                let value = parameter[1]
                dict[key] = value
                
                return dict
            }
        
        guard let token = parameters["access_token"],
              let userIdString = parameters["user_id"],
              let _ = Int(userIdString) else {
            
            decisionHandler(.allow)
            return
        }
        
        Session.shared.token = token
        Session.shared.userid = Int(userIdString)!
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let targetVC = storyBoard.instantiateViewController(identifier: "loadingVC")
        targetVC.modalPresentationStyle = .fullScreen
        self.present(targetVC, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}
