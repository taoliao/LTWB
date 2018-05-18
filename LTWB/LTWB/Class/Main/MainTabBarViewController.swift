//
//  MainTabBarViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

//    private lazy var heighlightedImages = ["tabbar_home_highlighted","tabbar_message_center_highlighted","","tabbar_discover_highlighted","tabbar_profile_highlighted"]
    private lazy var composeBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComposeBtn()
       
    }
    
}
//MARK: 设置tabBar UI
extension MainTabBarViewController {
    
    private func setComposeBtn() {
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        composeBtn.sizeToFit()
        composeBtn.center = CGPoint(x: tabBar.bounds.size.width*0.5, y: tabBar.bounds.size.height*0.5)
        tabBar.addSubview(composeBtn)
    }
    /*
    private func setTabBarItems() {
        for i in 0..<tabBar.items!.count {
        let item = tabBar.items![i]
        if i == 2 {
        item.isEnabled = false
        }
        item.selectedImage = UIImage(named: heighlightedImages[i])
        }
    }*/
    
}


/* 通过json文件动态添加子控制器
guard let path = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
    return
}
guard  let data = NSData(contentsOfFile: path) else {
    return
}
let anyObject = try? JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)

guard let dictArr = anyObject as? [[String : AnyObject]] else {
    return
}
for dict in dictArr {
    guard let vcName = dict["vcName"] as? String else {
        continue
    }
    guard let title = dict["title"] as? String else {
        continue
    }
    guard let imageName = dict["imageName"] as? String else {
        continue
    }
    addChildViewControllers(childVC: vcName, title: title, imageName: imageName)
}

private func addChildViewControllers(childVC : String, title : String, imageName : String) -> Void {
    
    let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    let clsName = spaceName + "." + childVC
    
    guard let childVCType = NSClassFromString(clsName) as? UIViewController.Type else {
        print("没有获取到对应的控制器类型")
        return
    }
    
    let childVC = childVCType.init()
    
    childVC.title = title
    childVC.tabBarItem.image = UIImage(named: imageName)
    childVC.tabBarItem.selectedImage = UIImage(named: imageName+"_"+"highlighted")
    let navigationController = UINavigationController(rootViewController: childVC)
    
    self.addChildViewController(navigationController)
    
}*/
