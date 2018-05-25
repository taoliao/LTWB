//
//  BaseTableViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/21.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage

class BaseTableViewController: UITableViewController {

    var isLogIn : Bool = false
    lazy var visitorView = VisitorView.vistorView()
    
    override func loadView() {
        
        guard var filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first else {
            return
        }
        filePath = (filePath as NSString).appendingPathComponent("userAcount.plist")
        
         let userAcount = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? TLUserAcount
       
         if let userInfo = userAcount {
            if let expires_Date = userInfo.expires_Date {//判断access_token是否过期
                 isLogIn = expires_Date.compare(Date()) == ComparisonResult.orderedDescending
            }
         }
        isLogIn ? super.loadView() : setUpVisitorVirw()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        
    }

}

//MARK:设置UI
extension BaseTableViewController {
    func setUpVisitorVirw() {
        view = visitorView
        visitorView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        visitorView.logInBtn.addTarget(self, action: #selector(logInBtnClick), for: .touchUpInside)
    }
    
    //设置导航栏按钮
    private func setNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(logInBtnClick))
    }
    
}

//MARK:事件监听
extension BaseTableViewController {
    @objc private func registerBtnClick() {
        print(#function)
        
    }
    @objc private func logInBtnClick() {
         let oathVC = UINavigationController(rootViewController: OauthViewController())
         present(oathVC, animated: true, completion: nil)
    }
    
}

