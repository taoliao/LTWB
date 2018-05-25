//
//  TLUserAcount.swift
//  LTWB
//
//  Created by corepress on 2018/5/25.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLUserAcount: NSObject,NSCoding{
   @objc var access_token : String?
   @objc var uid : String?
    @objc var expires_in : TimeInterval = 0.0 {
        didSet {
            expires_Date = Date(timeIntervalSinceNow: expires_in)
        }
    }
   @objc var expires_Date : Date?  //access_tokenguo过期的日期
   @objc var screen_name : String?
   @objc var avatar_large : String?
    
    override init() {
    }
    init(dic : [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //设置打印
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token","expires_in","uid","expires_Date","screen_name","avatar_large"]).description
    }
    
    //解档
    required init?(coder aDeCoder: NSCoder){
        access_token = aDeCoder.decodeObject(forKey: "access_token") as? String
        uid = aDeCoder.decodeObject(forKey: "uid") as? String
        expires_Date = aDeCoder.decodeObject(forKey: "expires_Date") as? Date
        screen_name = aDeCoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDeCoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    //归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_Date, forKey: "expires_Date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")

    }
    
}


