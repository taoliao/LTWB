//
//  TLComPoseTitleView.swift
//  LTWB
//
//  Created by corepress on 2018/6/6.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SnapKit

class TLComPoseTitleView: UIView {

    lazy var comPoseLable : UILabel = UILabel()
    lazy var screenNameLable : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpFrameAndText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension TLComPoseTitleView {
    
    private func setUpFrameAndText() {
        
        addSubview(comPoseLable)
        addSubview(screenNameLable)
        
        var offset = 0.0
        
        if #available(iOS 11.0, *) {
             offset = -20.0
        }else {
             offset = 0.0
        }
        comPoseLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(offset)
        }
        screenNameLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(comPoseLable.snp.centerX)
            make.top.equalTo(comPoseLable.snp.bottom).offset(3)
        }
        comPoseLable.font = UIFont.systemFont(ofSize: 16.0)
        comPoseLable.text = "发微博"
        screenNameLable.font = UIFont.systemFont(ofSize: 14.0)
        screenNameLable.textColor = UIColor.lightGray
        screenNameLable.text = TLUserAcountViewModel.shareInstance.userAcount?.screen_name
    }
    
}

