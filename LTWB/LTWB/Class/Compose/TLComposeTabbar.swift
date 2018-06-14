//
//  TLComposeTabbar.swift
//  LTWB
//
//  Created by corepress on 2018/6/8.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

protocol ComposeTabbarDelegate :  NSObjectProtocol{
     func composeTabbarBtnClick(tag : Int)
}


class TLComposeTabbar: UITabBar {
    weak var delegate_cmp: ComposeTabbarDelegate?
    lazy var imageNames : [String] = [String]()
    convenience init(image_names : [String]) {
        self.init()
        imageNames = image_names
        setupUI()
    }
}

extension TLComposeTabbar {
    
    private func setupUI() {
        
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 49, width: UIScreen.main.bounds.size.width, height: 49)
        
        let itemWidth = self.bounds.size.width/4
        let itemHeight = self.bounds.size.height

        var i : CGFloat = 0.0
        for image_name in imageNames {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: i*itemWidth, y: 0, width: itemWidth, height: itemHeight)
            btn.setTitle(image_name, for: .normal)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.tag = Int(i)
            btn.addTarget(self, action: #selector(self.composeTabbarBtnTap(btn:)), for: .touchUpInside)
            self.addSubview(btn)
             i+=1
        }
    }
}

extension TLComposeTabbar: ComposeTabbarDelegate {
     func composeTabbarBtnClick(tag: Int) {}
    
    @objc func composeTabbarBtnTap(btn : UIButton) {
        delegate_cmp?.composeTabbarBtnClick(tag: btn.tag)
    }
}


