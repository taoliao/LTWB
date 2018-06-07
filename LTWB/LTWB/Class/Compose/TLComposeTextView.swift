//
//  TLComposeTextView.swift
//  LTWB
//
//  Created by corepress on 2018/6/6.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SnapKit

class TLComposeTextView: UITextView {

    lazy var placeHolderLable : UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }

}

extension TLComposeTextView {
    
    private func setUpUI() {
        
        addSubview(placeHolderLable)
        
        placeHolderLable.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(7.5)
            make.left.equalTo(self).offset(14)
        }
        
        placeHolderLable.text = "分享新鲜事..."
        placeHolderLable.textColor = UIColor.lightGray
        placeHolderLable.font = UIFont.systemFont(ofSize: 16.0)
        textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 0, right: 10)
        
        delegate = self
    }
    
}

extension TLComposeTextView:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        if  textView.text == "" {
            placeHolderLable.isHidden = false
        }else {
            placeHolderLable.isHidden = true
        }
    }
    
}


