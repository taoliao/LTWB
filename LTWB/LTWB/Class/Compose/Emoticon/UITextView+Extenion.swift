//
//  UI+Extenion.swift
//  LTWB
//
//  Created by corepress on 2018/6/20.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

extension UITextView {
    
    //插入表情
    func insertEmoticon(emoticon : TLEmoticon) {
        if emoticon.isEmpty {
            return
        }
        if emoticon.isRemove {  //删除光标字符
            deleteBackward()
            return
        }
        if let emjiCode = emoticon.emjiCode {  //插入emoji
            replace(selectedTextRange!, withText: emjiCode)
            return
        }
        //处理普通表情
        let font = self.font!
        let attachment = TLEmoticonAttachment()
        attachment.chs = emoticon.chs!
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let image_attStr = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
        let rang = selectedRange
        mutableAttributedString.replaceCharacters(in: rang, with: image_attStr)
        attributedText = mutableAttributedString
        self.font = font
        selectedRange = NSRange(location: rang.location + 1, length: 0)
    }
    
    //获取表情字符串
    func getEmoticonString() -> String {
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
        let rang = NSRange(location: 0, length: mutableAttributedString.length)
        mutableAttributedString.enumerateAttributes(in: rang, options: []) { (dict, rang, _) in
            if let attachment = dict[NSAttributedStringKey.attachment] as? TLEmoticonAttachment {
                mutableAttributedString.replaceCharacters(in: rang, with: attachment.chs!)
            }
        }
        return mutableAttributedString.string
    }
    
    
}
