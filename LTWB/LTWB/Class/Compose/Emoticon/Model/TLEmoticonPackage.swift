//
//  TLEmoticonPackage.swift
//  LTWB
//
//  Created by corepress on 2018/6/14.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLEmoticonPackage: NSObject {
    
    var tl_emoticons : [TLEmoticon] = [TLEmoticon]()

    init(id : String) {
        super.init()
        
        if id == "" {
            //添加空白表情
            insertEmptyEmoticon(isEmpty: true)
            return
        }
        
        guard let path = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle") else {
            return
        }
        let emoticonDatas = NSDictionary(contentsOfFile: path) as! [String : Any]
        
        let emoticons = emoticonDatas["emoticons"] as! [[String : String]]
        
        var index = 0
        for var emoticon in emoticons {
            if let png = emoticon["png"] {
                emoticon["png"] = "\(id)/" + png
            }
           tl_emoticons.append(TLEmoticon(emoticons: emoticon))
            index+=1
            //插入删除按钮
            if index == 20 {
                 index = 0
                 tl_emoticons.append(TLEmoticon(isRemove: true))
            }
       }
        
        let count = tl_emoticons.count % 21
        if count == 0 {  //正好一页
            return
        }
        for _ in count..<20 {//添加空白表情
             tl_emoticons.append(TLEmoticon(isEmpty: true))
        }
         tl_emoticons.append(TLEmoticon(isRemove: true))
        
   }
    
    func insertEmptyEmoticon(isEmpty : Bool) {
        for _ in 0..<20 {
            tl_emoticons.append(TLEmoticon(isEmpty: true))
        }
        tl_emoticons.append(TLEmoticon(isRemove: true))
    }
    
    
}
