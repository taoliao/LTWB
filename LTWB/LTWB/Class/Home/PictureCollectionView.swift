//
//  PictureCollectionView.swift
//  LTWB
//
//  Created by corepress on 2018/5/31.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage

class PictureCollectionView: UICollectionView {

    var picture_urls : [URL] = [URL]() {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
         dataSource = self
    }
    
}

extension PictureCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picture_urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCellID", for: indexPath) as! PictureCell
        cell.backgroundColor = UIColor.gray
        cell.picture_url = picture_urls[indexPath.item]
        
        return cell
    }

}

class PictureCell: UICollectionViewCell {
    private lazy var pictureView = UIImageView()
    
    var picture_url : URL? {
        didSet {
            pictureView.sd_setImage(with: picture_url ,placeholderImage: nil, options: [], completed: nil)
        }
    }

    override init(frame: CGRect) {
         super.init(frame: frame)
        
         pictureView.frame = contentView.bounds
         pictureView.clipsToBounds = true
         pictureView.backgroundColor = UIColor.gray
         pictureView.contentMode = .scaleAspectFill
         contentView.addSubview(pictureView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

