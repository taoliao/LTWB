//
//  Date+Extension.swift
//  LTWB
//
//  Created by corepress on 2018/5/30.
//  Copyright © 2018年 corepress. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func creatDateString(creat_at : String) -> String {

        let dateFormeter = DateFormatter()
        dateFormeter.locale = Locale(identifier: "en")
        dateFormeter.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        guard let creat_date = dateFormeter.date(from: creat_at) else {
            return ""
        }
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince(creat_date))
        
        if interval < 60 {
            return "刚刚"
        }
        if interval < 60*60 {
            return "\(interval/60)分钟前"
        }
        if interval < 60*60*24 {
            return "\(interval/(60*60))小时前"
        }
        let calendar = Calendar.current
        //判断是否在昨天
        if calendar.isDateInYesterday(creat_date) {
            dateFormeter.dateFormat = "昨天 HH:mm"
            let timeStr = dateFormeter.string(from: creat_date)
            return timeStr
        }
        //判断是否是当年内
        let dateComponents = calendar.dateComponents(Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second]), from: creat_date, to: nowDate)
        if dateComponents.year! < 1 {
            dateFormeter.dateFormat = "MM dd HH:mm"
            let timeStr = dateFormeter.string(from: creat_date)
            return timeStr
        }
        //一年之前
        dateFormeter.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = dateFormeter.string(from: creat_date)
        return timeStr
        
    }
    
    
}

