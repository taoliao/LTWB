//
//  TLPicPickerCollection.swift
//  LTWB
//
//  Created by corepress on 2018/6/11.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

private let picPickerCellID = "picPickerCellID"
private let picMargrin : CGFloat = 10.0

class TLPicPickerCollection: UICollectionView {
    var imageArr = [UIImage]() {
        didSet {
            reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        register(UINib.init(nibName: "TLPicPickerCell", bundle: nil), forCellWithReuseIdentifier: picPickerCellID)
        dataSource = self
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = (UIScreen.main.bounds.size.width - 4*picMargrin)/3
        layout.itemSize = CGSize(width:itemWidth , height: itemWidth)
        layout.minimumLineSpacing = picMargrin
        layout.minimumInteritemSpacing = picMargrin
        contentInset = UIEdgeInsetsMake(picMargrin, picMargrin, 0, picMargrin)

    }
}

extension TLPicPickerCollection : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageArr.count == 9 {
            return imageArr.count
        }else {
            return imageArr.count + 1
        }
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCellID, for: indexPath) as! TLPicPickerCell

        if imageArr.count == 9 {
            cell.image = imageArr[indexPath.item]
        }else {
            if  indexPath.item<=imageArr.count - 1 {
                cell.image = imageArr[indexPath.item]
            }else {
                cell.image = nil
            }
        }
        return cell
    }
    

}

