//
//  TLHomeViewCell.swift
//  LTWB
//
//  Created by corepress on 2018/5/30.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage

private let leftMargin:CGFloat = 15.0
private let imageMargin:CGFloat = 5.0
let pictureCellID:String = "pictureCellID"

class TLHomeViewCell: UITableViewCell {

    @IBOutlet weak var contentLableWCon: NSLayoutConstraint!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var verfiledView: UIImageView!
    @IBOutlet weak var screenNameLable: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var creat_at_lable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var contenLable: UILabel!
    @IBOutlet weak var pictureView: PictureCollectionView!
    
    @IBOutlet weak var pictureBoomMargin: NSLayoutConstraint!
    @IBOutlet weak var pictureWCons: NSLayoutConstraint!
    @IBOutlet weak var pictureViewHCons: NSLayoutConstraint!
    var viewModel : StatusesViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            if let profile_image_str = viewModel.statuses?.user?.profile_image_url,profile_image_str != ""{
                 let profileUrl = URL(string: profile_image_str)
                 profileView.sd_setImage(with: profileUrl, placeholderImage: UIImage(named:"avatar_default"), options: [], completed: nil)
            }
            verfiledView.image = viewModel.verified_image
            vipView.image = viewModel.vip_image
            screenNameLable.text = viewModel.statuses?.user?.screen_name
            creat_at_lable.text = viewModel.sourceStr
            timeLable.text = viewModel.created_at_text
            contenLable.text = viewModel.statuses?.text
            
            screenNameLable.textColor = viewModel.vip_image == nil ? UIColor.black : UIColor.orange
            
            let pictureViewSize = handlePictureViewWIthPictureURLs(picture_count: viewModel.imageURLS.count)
            pictureWCons.constant = pictureViewSize.width
            pictureViewHCons.constant = pictureViewSize.height
            
            pictureView.picture_urls = viewModel.imageURLS
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLableWCon.constant = UIScreen.main.bounds.width - leftMargin*2
    
        let flowLayout = pictureView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        pictureView.register(UINib.init(nibName: "TLPictureCell", bundle: nil), forCellWithReuseIdentifier: pictureCellID)
    
    }
    
}

extension TLHomeViewCell {
    //处理pictureView的宽高
    func handlePictureViewWIthPictureURLs(picture_count : Int) -> CGSize {
        if picture_count == 0 {
            pictureBoomMargin.constant = 0.0
            return CGSize.zero
        }
        pictureBoomMargin.constant = 10.0
        
        let flowLayout = pictureView.collectionViewLayout as! UICollectionViewFlowLayout
        
//        //处理单张图片
        if picture_count == 1 {
            //从磁盘中获取图片
            let diskPatch = self.viewModel?.imageURLS.last?.absoluteString
            let patch = diskPatch!
            guard let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: patch) else {
                 return CGSize.zero
            }
            //设置单张图片 layout.itemSize 的大小
            let size = image.size
            flowLayout.itemSize = size
            return  CGSize(width: UIScreen.main.bounds.width - 2*leftMargin, height: size.height)
        }
        //图片的宽度和高度
        let pictureWidth = (UIScreen.main.bounds.width - 2*leftMargin - 2*imageMargin)/3
        
         //设置多张图片 layout.itemSize 的大小
        flowLayout.itemSize = CGSize(width: pictureWidth, height: pictureWidth)
        
        if picture_count == 4 {
            let imageWidth = pictureWidth*2 + imageMargin
            return CGSize(width: imageWidth, height: imageWidth)
        }
        //计算行数
        let rows = CGFloat((picture_count - 1) / 3 + 1)
        //PictureView的高度
        let pictureViewH = rows*pictureWidth + (rows - 1)*imageMargin
        //PictureView的宽度
        let pictureViewW = UIScreen.main.bounds.width - leftMargin*2
        
        return CGSize(width: pictureViewW, height: pictureViewH)
    }
}



