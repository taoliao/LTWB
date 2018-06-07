//
//  TLComposeViewController.swift
//  LTWB
//
//  Created by corepress on 2018/6/6.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLComposeViewController: UIViewController {

    private lazy var titleView : TLComPoseTitleView = TLComPoseTitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        
    }

}

//MARK:设置UI
extension TLComposeViewController {
    
    private func setUpNavigationBar() {
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(goback))
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(compose))
         self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        navigationItem.titleView = titleView
        
    }
    
}

//MARK:事件监听
extension TLComposeViewController {
    
   @objc private func goback() {
       dismiss(animated: true, completion: nil)
    }
    
    @objc private func compose() {
        print(#function)
    }
    
}
