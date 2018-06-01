//
//  TLUserAcountModel.swift
//  LTWB
//
//  Created by corepress on 2018/5/28.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLUserAcountViewModel {
    //单列
    static let shareInstance = TLUserAcountViewModel()
    
    var userAcount : TLUserAcount?
    //计算属性
    var filePath : String {
         let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first
         return  (path! as NSString).appendingPathComponent("userAcount.plist")
    }
     //计算属性
    var isLogin : Bool {
        if userAcount == nil {
            return false
        }
        guard let user = userAcount else {
            return false
        }
        return user.expires_Date?.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    init() {
         userAcount = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? TLUserAcount
    }
    
}
