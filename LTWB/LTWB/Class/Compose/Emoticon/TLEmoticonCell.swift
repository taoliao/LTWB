//
//  TLEmoticonCell.swift
//  LTWB
//
//  Created by corepress on 2018/6/14.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLEmoticonCell: UICollectionViewCell {
    
    private lazy var emoticonBtn : UIButton = UIButton()
    
    var emoticon : TLEmoticon? {
        didSet {
            guard let emoticon = emoticon else {
                return
            }
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emoticonBtn.setTitle(emoticon.emjiCode, for: .normal)

            if emoticon.isRemove {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        emoticonBtn.frame = self.bounds
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        emoticonBtn.isUserInteractionEnabled = false
        self.addSubview(emoticonBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
