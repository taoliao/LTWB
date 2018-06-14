//
//  Comment.swift
//  LTWB
//
//  Created by corepress on 2018/5/24.
//  Copyright © 2018年 corepress. All rights reserved.
//

import Foundation
import UIKit

let  AppKey = "3809142420"
let AppSecret = "d12dd6b4543fceffe786a214de4200cf"
let redirect_uri = "http://www.baidu.com"

let IS_iPhoneX = UIScreen.main.bounds.size == CGSize(width: 1125, height: 2436) ? true : false

let IPHONE_NAVIGATIONBAR_HEIGHT = IS_iPhoneX ? 88.0: 64.0

let IPHONE_TARBAR_HEIGHT = IS_iPhoneX ? 83.0 : 49.0

let PICPICKERBTNCLICKNOTI = "PICPICKERBTNCLICKNOTI"
let PICPICKERDELETEBTNCLICKNOTI = "PICPICKERDELETEBTNCLICKNOTI"
