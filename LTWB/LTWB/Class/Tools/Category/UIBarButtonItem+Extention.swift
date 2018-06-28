//
//  UIBarButtonItem+Extention.swift
//  LTWB
//
//  Created by corepress on 2018/5/22.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    convenience init(imageName : String) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.init(customView: btn)
    } */
    convenience init(imageName : String) {
        self.init()
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        customView = btn
     }
    

    
}
