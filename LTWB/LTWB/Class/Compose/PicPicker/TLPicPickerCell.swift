//
//  TLPicPickerCell.swift
//  LTWB
//
//  Created by corepress on 2018/6/11.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLPicPickerCell: UICollectionViewCell {
    var image : UIImage?  {
        didSet {
            if image == nil {
                imageBtn.setBackgroundImage(UIImage(named:"AlbumAddBtn"), for: .normal)
                imageView.image = nil
                imageBtn.isUserInteractionEnabled = true
                delegateBtn.isHidden = true
            }else {
                imageView.image = image
                imageBtn.isUserInteractionEnabled = false
                delegateBtn.isHidden = false
            }
        }
        
    }
    
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var delegateBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func picPickerBtnClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PICPICKERBTNCLICKNOTI), object: nil)
    }
    @IBAction func deleteBtnClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PICPICKERDELETEBTNCLICKNOTI), object: imageView.image)
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
