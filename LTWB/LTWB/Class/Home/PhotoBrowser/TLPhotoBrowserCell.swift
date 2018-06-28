//
//  TLPhotoBrowserCell.swift
//  LTWB
//
//  Created by corepress on 2018/6/27.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage

class TLPhotoBrowserCell: UICollectionViewCell {
    
    var imageUrl : URL? {
        didSet {
            guard let imageUrl = imageUrl else {
                return
            }
            self.setupImage(imageUrl: imageUrl)
        }
    }
    var scrollView : UIScrollView = UIScrollView()
    var imageView : UIImageView = UIImageView()
    var progressView : TLProgressView = TLProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TLPhotoBrowserCell {
    
    func setupImage(imageUrl : URL) {
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: imageUrl.absoluteString)
        let width = UIScreen.main.bounds.width
        let height = width / (image?.size.width)! *  (image?.size.height)!
        var y : CGFloat = 0
        if height > UIScreen.main.bounds.height {
            y = 0
        }else {
            y = (UIScreen.main.bounds.height - height)/2
        }
        imageView.frame = CGRect(x: 0, y: y, width: width, height: height)
        
        progressView.isHidden = false
        imageView.sd_setImage(with: replaceWithBigImageURL(small_url: imageUrl), placeholderImage: image, options: [], progress: { (currect, total, _) in
            self.progressView.progress = CGFloat(currect) / CGFloat(total)
        }) { (_, _, _, _) in
            self.progressView.isHidden = true
        }
        scrollView.contentSize = CGSize(width: 0, height: height)
        
    }
    func replaceWithBigImageURL(small_url:URL) -> URL {
        let small_url = small_url.absoluteString
        let large_url = (small_url as NSString).replacingOccurrences(of: "thumbnail", with: "bmiddle")
        return URL(string: large_url)!
        
    }
    
}

extension TLPhotoBrowserCell {
    
    func setupUI() {
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        contentView.addSubview(progressView)
        
        progressView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5)
        progressView.isHidden = true
        
        scrollView.frame = contentView.bounds
        
    }

}


