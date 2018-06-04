//
//  TLPictureCell.swift
//  LTWB
//
//  Created by corepress on 2018/6/4.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage

class TLPictureCell: UICollectionViewCell {
    
    var picture_url : URL? {
        didSet {
            contentView.backgroundColor = UIColor.gray
            photoView.sd_setImage(with: picture_url, placeholderImage: nil, options: [], completed: nil)
        }
    }
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
