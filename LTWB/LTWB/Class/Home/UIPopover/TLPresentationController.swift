//
//  TLPresentationController.swift
//  LTWB
//
//  Created by corepress on 2018/5/22.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLPresentationController: UIPresentationController {
    var presentedViewFrame = CGRect.zero
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = presentedViewFrame
        setUpCorverView()
        
    }
}

//MARK:设置UI
extension TLPresentationController {
    //添加蒙版
    func setUpCorverView() {
        
        let coverView = UIView(frame: containerView!.bounds)
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        containerView?.insertSubview(coverView, belowSubview: presentedView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewTaped))
        tap.numberOfTapsRequired = 1
        coverView.addGestureRecognizer(tap)
    }
    
}

//MARK:事件监听
extension TLPresentationController {
    @objc private func coverViewTaped() {
       presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}

