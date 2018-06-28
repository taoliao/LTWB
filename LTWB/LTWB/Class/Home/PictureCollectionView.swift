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
         delegate = self
    }
    
}

extension PictureCollectionView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picture_urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureCellID, for: indexPath) as! TLPictureCell

        cell.picture_url = picture_urls[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PictureClickNoti), object: nil, userInfo: [PictureIndexPatch : indexPath,ImageUrlKey : picture_urls])
        
    }

}


