//
//  HomeViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {
    private lazy var titleBtn = TitleButton()
    private lazy var popoverAnimtor = PopoverAnimatior { (presented) in
        self.titleBtn.isSelected = presented
    }
    //MARK:系统调用
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.addRotationAnim()
        //登录之后的设置
        if !isLogIn {
            return
        }
        setNavigationItem()
        setTitleView()
    }
    
}

//MARK:设置UI
extension HomeViewController {
    
    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
    }
    
    private func setTitleView() {
        titleBtn.setTitle("仙文文ww", for: .normal)
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(titleBtnClick(titleBtn:)), for: .touchUpInside)
    }
    
}
//MARK: 事件监听
extension HomeViewController {
    
    @objc private func titleBtnClick(titleBtn : TitleButton) {
        titleBtn.isSelected = !titleBtn.isSelected
        
        let popVC = PopoverViewController()
        //modalPresentationStyle=.custom modal出来之后 之前的视图不会消失
        popVC.modalPresentationStyle = .custom
        popVC.transitioningDelegate = popoverAnimtor
        popoverAnimtor.presentedViewFrame = CGRect(x: 100, y: 55, width: 180, height: 250)
        present(popVC, animated: true, completion: nil)
        
    }

}











