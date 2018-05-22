//
//  VisitorView.swift
//  LTWB
//
//  Created by corepress on 2018/5/21.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    @IBOutlet weak var zhuangpanView: UIImageView!
    @IBOutlet weak var houseView: UIImageView!
    @IBOutlet weak var messagelable: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    
    class func vistorView() -> VisitorView{
        return   Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
    func setUpVisitorViewInfo(iconName : String, title : String) {
        zhuangpanView.isHidden = true
        houseView.image = UIImage(named: iconName)
        messagelable.text = title
    }
    
    //MARK:添加转盘的旋转动画
    func addRotationAnim() {
        let baseAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        baseAnim.fromValue = 0
        baseAnim.toValue = Double.pi
        baseAnim.duration = 5
        baseAnim.repeatCount = MAXFLOAT
        baseAnim.isRemovedOnCompletion = false
        zhuangpanView.layer.add(baseAnim, forKey: nil)
        
    }
    

}
