//
//  TLEmoticonController.swift
//  LTWB
//
//  Created by corepress on 2018/6/14.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

private let EmoticonCell = "EmoticonCell"

class TLEmoticonController: UIViewController {

    var emoticonClickCallBack : (_ emoticon : TLEmoticon)->()  //将表情回调出去的闭包
    
    private lazy var collectView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmoticonCollectionViewFlowLayout())
    private lazy var toolBar : UIToolbar = UIToolbar()
    private lazy var emoticonManger = TLEmoticonManger()
    
    init(emoticonClickCallBack: @escaping(_ emoticon : TLEmoticon)->()) {
        self.emoticonClickCallBack = emoticonClickCallBack
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

//MARK:设置UI
extension TLEmoticonController {
    func setupUI() {
        view.addSubview(collectView)
        view.addSubview(toolBar)
        collectView.backgroundColor = UIColor.white
//        toolBar.backgroundColor = UIColor.green
        collectView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tBar" : toolBar, "cView" : collectView] as [String : Any]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cView]-0-[tBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        prepareForCollectionView()
        prepareForToolBar()
    }
    
    func prepareForCollectionView() {
        collectView.dataSource = self
        collectView.delegate = self
        collectView.register(TLEmoticonCell.self, forCellWithReuseIdentifier: EmoticonCell)
    }
    func prepareForToolBar() {
        let titles = ["最近","默认","emoji","小浪花"]
        var tag = 0
        var tempItems : [UIBarButtonItem] = [UIBarButtonItem]()
        for title in titles {
            let barItem = UIBarButtonItem (title: title, style: .plain, target: self, action: #selector(toolBarItemClick(barItem:)))
            barItem.tag = tag
            tag+=1
            tempItems.append(barItem)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))//加弹簧分割
        }
        tempItems.removeLast()
        toolBar.tintColor = UIColor.orange
        toolBar.items = tempItems
    }
    
}

//MARK:事件监听
extension TLEmoticonController {
    @objc private func toolBarItemClick(barItem : UIBarButtonItem) {
        
        let indexPatch = IndexPath(item: 0, section: barItem.tag)
        
        let emoticon_package = emoticonManger.emoticon_packages[indexPatch.section]
        let emoticons = emoticon_package.tl_emoticons
        if emoticons.count == 0 {
//            collectView.reloadData()
            return
        }
        collectView.scrollToItem(at: indexPatch, at: .left, animated: true)
    }
    
}

extension TLEmoticonController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoticonManger.emoticon_packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emoticon_package = emoticonManger.emoticon_packages[section]
        return emoticon_package.tl_emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCell, for: indexPath) as! TLEmoticonCell
        
        let emoticon_package = emoticonManger.emoticon_packages[indexPath.section]
        
        let emoticon = emoticon_package.tl_emoticons[indexPath.item]
        
        cell.emoticon = emoticon
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoticon_package = emoticonManger.emoticon_packages[indexPath.section]
        let emoticon = emoticon_package.tl_emoticons[indexPath.item]
        
        //插入最近表情
        insertRecentEmoticon(emoticon: emoticon)
        
        //将选中表情回调给控制器
        self.emoticonClickCallBack(emoticon)
    }
    
    func insertRecentEmoticon(emoticon : TLEmoticon) {
        if emoticon.isEmpty || emoticon.isRemove {  //空白和删除不要添加
            return
        }
        if (emoticonManger.emoticon_packages.first?.tl_emoticons.contains(emoticon))! {  //如果包含表情 就移除
            let index = emoticonManger.emoticon_packages.first?.tl_emoticons.index(of: emoticon)
            emoticonManger.emoticon_packages.first?.tl_emoticons.remove(at: index!)
             emoticonManger.emoticon_packages.first?.tl_emoticons.insert(emoticon, at: index!)
        }else {
            emoticonManger.emoticon_packages.first?.tl_emoticons.remove(at: 19)
            emoticonManger.emoticon_packages.first?.tl_emoticons.insert(emoticon, at: 0)
        }
          collectView.reloadData()
    }
    
}

class EmoticonCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        let itemWidth = UIScreen.main.bounds.size.width/7
        itemSize = CGSize(width: itemWidth, height: itemWidth)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        collectionView!.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        scrollDirection = .horizontal
        let verticalMargrin = ((collectionView?.bounds.size.height)! - 3*itemWidth)/2
        collectionView?.contentInset = UIEdgeInsetsMake(verticalMargrin, 0, verticalMargrin, 0)
        
    }
    
}





