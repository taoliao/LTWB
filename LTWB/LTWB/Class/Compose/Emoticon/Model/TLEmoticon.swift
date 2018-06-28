//
//  TLEmoticon.swift
//  LTWB
//
//  Created by corepress on 2018/6/14.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLEmoticon: NSObject {
    
    @objc var code : String? {
        didSet {
            guard let code = code else {
                return
            }
            //将emji code 转成emjiCode 固定写法
            let scanner = Scanner(string: code)
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            let c = Character(UnicodeScalar(value)!)
            emjiCode = String(c)
        }
    }
    @objc var chs : String?
    @objc var png : String? {
        didSet {
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    @objc var pngPath : String?
    @objc var emjiCode : String?
    var isRemove = false
    var isEmpty = false
    
    init(emoticons : [String : String]) {
        super.init()
        setValuesForKeys(emoticons)
    }
    //构造删除按钮
    init(isRemove : Bool) {
        self.isRemove = isRemove
    }
    //空白表情
    init(isEmpty : Bool) {
        self.isEmpty = isEmpty
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["emjiCode","chs","pngPath"]).description
    }
    
}
