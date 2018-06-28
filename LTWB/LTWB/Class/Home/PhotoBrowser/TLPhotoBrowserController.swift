//
//  TLPhotoBrowserController.swift
//  LTWB
//
//  Created by corepress on 2018/6/27.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

private let ppictureCellID = "pictureCellID"

class TLPhotoBrowserController: UIViewController {

    var collecetionView : UICollectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: PictureCollectionViewFlowLayout())
    var saveBtn : UIButton = UIButton(title: "保存", backgroundColor: UIColor.darkGray, font: UIFont.systemFont(ofSize: 14.0), titleColor: UIColor.white)
    var closeBtn : UIButton = UIButton(title: "关闭", backgroundColor: UIColor.darkGray, font: UIFont.systemFont(ofSize: 14.0), titleColor: UIColor.white)
    
    var indexPatch : IndexPath?
    var image_urls : [URL] = [URL]()
    
    init(indexPatch : IndexPath,image_urls : [URL]) {
        self.indexPatch = indexPatch
        self.image_urls = image_urls
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        collecetionView.dataSource = self
        collecetionView.register(TLPhotoBrowserCell.self, forCellWithReuseIdentifier: ppictureCellID)
        
    }

}
//MARK:UI设置
extension TLPhotoBrowserController {
    func setupUI() {
        view.addSubview(collecetionView)
        view.addSubview(saveBtn)
        view.addSubview(closeBtn)
        saveBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        closeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(saveBtn.snp.bottom)
            make.size.equalTo(saveBtn.snp.size)
        }
        saveBtn.addTarget(self, action: #selector(savePictureBtnClick), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
    }
}
//MARK:事件监听
extension TLPhotoBrowserController {
    
    @objc private func savePictureBtnClick() {
        
        print(#function)
    }
   
    @objc private func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension TLPhotoBrowserController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collecetionView.dequeueReusableCell(withReuseIdentifier: ppictureCellID, for: indexPath) as! TLPhotoBrowserCell
        
        cell.imageUrl = image_urls[indexPath.item]
        
        return cell
    }
    
    
}

class PictureCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        itemSize = UIScreen.main.bounds.size
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
}






