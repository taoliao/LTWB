//
//  VisitorView.swift
//  LTWB
//
//  Created by corepress on 2018/5/21.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    class func vistorView() -> VisitorView{
        return   Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    

}
