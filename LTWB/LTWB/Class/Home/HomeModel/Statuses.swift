//
//  Statuses.swift
//  LTWB
//
//  Created by corepress on 2018/5/29.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class Statuses: NSObject {
     //微博创建时间
    @objc var created_at : String?
     //微博来源
    @objc var source : String?
   @objc var text : String?  //微博信息内容
   @objc var mid = 0 //微博MID
    var user : User?
   @objc var pic_urls : [[String : String]]?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        //填充user模型
        let userDict = dict["user"] as! [String : Any]
        user = User(dict : userDict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
