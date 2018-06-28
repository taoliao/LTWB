//
//  UIButton+Extension.swift
//  LTWB
//
//  Created by corepress on 2018/5/21.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

extension UIButton {
    /*  通过类方法创建Button
    class func creatButtonWithImages(imageName : String,bkImageName: String) ->UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for:.highlighted)
        btn.setBackgroundImage(UIImage(named:bkImageName), for: .normal)
        btn.setBackgroundImage(UIImage(named:bkImageName + "__highlighted"), for: .highlighted)
        btn.sizeToFit()
        return btn
    }
    */
    //convenience便利构造函数  必须调用self.init()
    convenience init(imageName : String, bkImageName : String) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named:bkImageName), for: .normal)
        setBackgroundImage(UIImage(named:bkImageName + "__highlighted"), for: .highlighted)
        sizeToFit()
    }
    
    
    convenience init(title : String, backgroundColor : UIColor, font: UIFont, titleColor : UIColor) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        titleLabel?.font = font
        
    }
    
    
}
