//
//  StatusesViewModel.swift
//  LTWB
//
//  Created by corepress on 2018/5/30.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class StatusesViewModel: NSObject {
    
    var statuses : Statuses?
    
    //处理属性
    var sourceStr : String?
    var created_at_text : String?
    var verified_image : UIImage?
    var vip_image : UIImage?
    var imageURLS : [URL] = [URL]()
    
    init(status : Statuses) {
        self.statuses = status
        
        //来源处理
        if let source = status.source, source != "" {
            let starIndex = (source as NSString).range(of: ">").location + 1
            let formIndex = (source as NSString).range(of: "</").location
            sourceStr = (source as NSString).substring(with: NSRange(location: starIndex, length: formIndex-starIndex))
        }
        //时间处理
        let dateStr = NSDate.creatDateString(creat_at: status.created_at!)
        created_at_text = dateStr
        
        let verified_type = status.user?.verified_type
        switch verified_type! {
        case 0:
            verified_image = UIImage(named: "avatar_vip")
        case 2,3,4:
            verified_image = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verified_image = UIImage(named: "avatar_grassroot")
        default:
            verified_image = nil
        }
        
        let mbrank = status.user?.mbrank
        if mbrank! > 0 && mbrank! <= 6 {
            vip_image = UIImage(named: "common_icon_membership_level\(mbrank!)")
        }
        
        //处理配图
        if let pic_urls = status.pic_urls {
            for image_url in pic_urls {
                let url_Str = image_url["thumbnail_pic"]!
                imageURLS.append(URL(string: url_Str)!)
            }
        }
        
        
    }
    

}
