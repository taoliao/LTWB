//
//  User.swift
//  LTWB
//
//  Created by corepress on 2018/5/30.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class User: NSObject {
    
     @objc var screen_name : String?
     @objc var profile_image_url : String?
     //会员等级
    @objc var mbrank : Int = 0
     //认证类别
    @objc var verified_type : Int = -1

    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
