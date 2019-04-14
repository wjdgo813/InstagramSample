//
//  LoginViewController.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 09/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import WebKit

import SnapKit

final class LoginViewController: BaseViewController {

    private var client: (id: String, redirectUri: String)
    private var webViewObservation: NSKeyValueObservation?
    
    private lazy var webView: WKWebView = {
        //
//        let webConfiguration = WKWebViewConfiguration()
//        webConfiguration.websiteDataStore = .nonPersistent()
        //제출 전에 꼭 지우기, 데이터 안쌓게 해주는 테스트용
//        let webView      = WKWebView(frame: .zero, configuration: webConfiguration)
        let webView = WKWebView(frame: .zero)
        webView.isOpaque = false
        webView.backgroundColor    = UIColor.white
        webView.navigationDelegate = self
        
        return webView
    }()
    
    private lazy var progressView : UIProgressView = {
        let progressView      = UIProgressView(progressViewStyle: .bar)
        progressView.progress = 0.0
        progressView.tintColor = UIColor.blue
        
        return progressView
    }()
    
    public init(clidentId: String, redirectUri: String){
        self.client.id = clidentId
        self.client.redirectUri = redirectUri
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWebView()
    }
    
    
    override func setupUI() {
        self.view.backgroundColor = .white
        self.setupProgressView()
        self.setupWebView()
    }
    
    
    private func setupProgressView(){
        self.view.addSubview(self.progressView)
        
        self.progressView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeArea.top)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(5)
        }
    }
    
    
    private func setupWebView(){
        self.view.addSubview(self.webView)
        
        self.webView.snp.makeConstraints{
            $0.top.equalTo(self.progressView.snp.bottom)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        self.webViewObservation = self.webView.observe(\.estimatedProgress, changeHandler: self.progressViewChangeHandler)
    }
    
    
    
    private func progressViewChangeHandler<Value>(webView: WKWebView, change: NSKeyValueObservedChange<Value>){
        self.progressView.alpha = 1.0
        self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        
        if webView.estimatedProgress >= 1.0 {
            self.progressView.alpha    = 1.0
            self.progressView.progress = 0
        }
    }
    
    
    private func loadWebView(){
        guard var components = URLComponents(string: "https://api.instagram.com/oauth/authorize/")
        else {
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: client.id),
            URLQueryItem(name: "redirect_uri", value: client.redirectUri),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "hl", value: "en")
        ]
        
        if let url = components.url {
            self.webView.load(URLRequest(url: url))
        }
    }
    
}


extension LoginViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("url : \(navigationAction.request.url?.absoluteString ?? "")")
        
        if let url = navigationAction.request.url?.absoluteString,
            let range = url.range(of: "#access_token="){
            UserDefaults.standard.setValue(String(url[range.upperBound...]), forKey: "AccessToken")
            NotificationCenter.default.post(name: NSNotification.Name.session.didChange, object: nil)
        }
        
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
    }
}
