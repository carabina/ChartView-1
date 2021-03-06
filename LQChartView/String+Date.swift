//
//  String+Date.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/22.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

extension String{
    ///日期字符串 -> 返回一个星期字符串 
    func weekDayFrom() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let weekDate = formatter.date(from: self)
        let weekDay = ["周日","周一","周二","周三","周四","周五","周六"]
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let componentsSet = Set<Calendar.Component>([.weekday])
        let components = calendar.dateComponents(componentsSet, from: weekDate!)
        return weekDay[components.weekday! - 1]
    }
    
}
