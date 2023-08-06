//
//  ViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 2.08.23.
//

import UIKit
import WebKit
import Alamofire

class ViewController: UIViewController, WKNavigationDelegate {

    let tempToken = "BQB64-uyuQhsmH28-yTnBilB9sI-3ld43MU9OcUaWP0bNp-Nm5yt4vEAzOoIAWgDftpV_pEa9-dpQD6AaVZ0X4aKb1Gys4nnlo28UsTG95CHwRim17M"
    var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://igly.by"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(AppConstants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        NetworkService.getData()
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = signInURL else { return }
        webView.load(URLRequest(url: url))
        testRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    func testRequest() {
        
//        wget --quiet \
//          --method GET \
//          --header 'Authorization: Bearer 1POdFZRZbvb...qqillRxMr2z' \
//          --output-document \
//          - https://api.spotify.com/v1/albums/4aawyAB9vmqN3uQ7FjRGTy
        
        
        let url = "https://api.spotify.com/v1/albums/4aawyAB9vmqN3uQ7FjRGTy"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tempToken)"
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                // Handle the successful response
                print(value)
            case .failure(let error):
                // Handle the error
                print(error)
            }
        }
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        print("Code: \(code)")
        if code != "" {
            webView.removeFromSuperview()
        }
        getToken(code: code)
    }
    
    func getToken(code: String) {

        var url = "https://accounts.spotify.com/api/token"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        let parameters: [String: String] = [
            "grant_type": "client_credentials",
            "client_id": AppConstants.clientID,
            "client_secret": AppConstants.clientSecret
        ]

        AF.request(url, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                // Handle the successful response
                print(value)
            case .failure(let error):
                // Handle the error
                print(error)
            }
        }
        
    }


}

