//
//  BaseTableViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/21.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var isLogIn : Bool = false
    lazy var visitorView = VisitorView.vistorView()
    
    override func loadView() {
        isLogIn ? super.loadView() : setUpVisitorVirw()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
    }

}

extension BaseTableViewController {
    func setUpVisitorVirw() {
        view = visitorView
    
    }
    
    
}
