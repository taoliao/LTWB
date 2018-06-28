//
//  TLFindEmoticon.swift
//  LTWB
//
//  Created by corepress on 2018/6/21.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLFindEmoticon: NSObject {
    
    static let shareInstance : TLFindEmoticon = TLFindEmoticon()
    
    private lazy var manger : TLEmoticonManger = TLEmoticonManger()
    
    func findAttstring(statusText : String?, font : UIFont) -> NSMutableAttributedString? {
        
        guard let statusText = statusText else {
            return nil
        }
        let mutableAttributedString = NSMutableAttributedString(string: statusText)
        let pattern = "\\[.*?\\]"  //规则字符串
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { //正则表达式对象
            return mutableAttributedString
        }
         //匹配获取结果
        let results = regex.matches(in: statusText, options: [], range: NSRange(location: 0, length: (statusText as NSString).length))
        
        if results.count > 0 {
            var index = results.count-1
            for _ in (0...results.count-1) {
                let result = results[index]
                index-=1
//                print((statusText as NSString).substring(with: result.range))
                let chs = (statusText as NSString).substring(with: result.range)
                guard let pngPath = matchTheEmoticons(match_chs: chs) else {
                    return mutableAttributedString
                }
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: pngPath)
                attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
                let attributeString = NSAttributedString(attachment: attachment)
                
                mutableAttributedString.replaceCharacters(in: result.range, with: attributeString)
            }
        }
        return mutableAttributedString
    }
    
    func matchTheEmoticons(match_chs : String) -> String?{
        for package in manger.emoticon_packages {
            for emoticon in package.tl_emoticons {
                if match_chs == emoticon.chs {
                    return emoticon.pngPath!
                }
            }
        }
        return nil
    }
    
    
}
