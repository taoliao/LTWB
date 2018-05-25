//
//  OauthViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/24.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class OauthViewController: UIViewController {
    
    lazy var webView = WKWebView(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
        
        view.addSubview(webView)
        webView.navigationDelegate = self
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(AppKey)&redirect_uri=\(redirect_uri)"
        guard let url = URL(string: urlStr) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
}

//MARK:WKNavigationDelegate
extension OauthViewController : WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    //MARK:在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        guard let urlStr = navigationAction.request.url?.absoluteString else {
             return
        }
        let contain = (urlStr as NSString).contains("code=")
        if contain {
            decisionHandler(.cancel)
        }else {
            decisionHandler(.allow)
        }
        guard contain else {
             return
        }
       let codeStr = (urlStr as NSString).components(separatedBy: "code=").last!
        loadAccess_token(code: codeStr)
        
    }

}

//MARK:设置UI
extension OauthViewController {
    
   private func setNavigationItem() {
        title = "用户登录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "回退", style:.plain, target: self, action: #selector(goBackAct))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style:.plain, target: self, action: #selector(fillAcountInfo))
    }
    
}

//MARK:事件响应
extension OauthViewController {
    
    @objc private func goBackAct() {
       dismiss(animated: true, completion: nil)
    }
    
    @objc private func fillAcountInfo() {
        let jsStr = "document.getElementById('userId').value='18273218100';document.getElementById('passwd').value='lt6864889';"
        webView.evaluateJavaScript(jsStr, completionHandler: nil)
    }
    
}

//MARK: 数据请求
extension OauthViewController {
    
    func loadAccess_token(code : String) {
        TLNetWorkTools.shared.requestAccesstoken(code: code) { (result, error) in
            if error == nil {
                print(result!)
            }else {
                print(error!)
            }
        }
    }
    
}


