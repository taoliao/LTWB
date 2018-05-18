//
//  MainTabBarViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    
    func addChildViewControllers(childVC : String, title : String, imageName : String) -> Void {
        
        let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let clsName = spaceName + "." + childVC
        
        guard let className = NSClassFromString(clsName) as? UIViewController.Type else {
            return
        }

         let childVC = className.init()
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName+"_"+"highlighted")
        let navigationController = UINavigationController(rootViewController: childVC)

        self.addChildViewController(navigationController)
        
    }

}
