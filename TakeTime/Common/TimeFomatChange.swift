//
//  TimeFomatChange.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/22.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class TimeFomatChange {
    
    
    /// 获取当前时间戳
    /// - Parameter strFormat: <#strFormat description#>
    class func getCurrentDateTime(_ strFormat : String = "yyyy-MM-dd HH:mm") -> String{
        let dateFor = DateFormatter()
        dateFor.dateFormat = strFormat
        return dateFor.string(from: Date())
    }
    
    
    /// 获取date标示
    /// - Parameter date: <#date description#>
    /// - Parameter dateFormat: <#dateFormat description#>
    class func getDateString(_ date:Date,_ dateFormat:String = "yyyyMMdd") -> String {
        let dateFor = DateFormatter()
        dateFor.dateFormat = dateFormat
        return dateFor.string(from: date)
    }
    
    /// 将秒时间戳转为string
    /// - Parameter iDate: 单位秒
    /// - Parameter strFormat: <#strFormat description#>
    class func getIntFormatDate(_ iDate:Int, strFormat : String = "yyyy-MM-dd HH:mm") -> Date{
        let dateFor = DateFormatter()
        dateFor.dateFormat = strFormat
        return Date(timeIntervalSince1970: TimeInterval(iDate))
    }
    
    /// 将秒时间戳转为string
    /// 单位秒
    class func getDateTimeFormat(_ allTime:Int) -> String{
        var hours = 0
        var minutes = 0
        var hoursText = ""
        var minutesText = ""
        hours = allTime / 3600
        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        return "\(hoursText):\(minutesText)"
    }
    
    /// 时分转为秒
    ///
    /// - Parameter stringTime: <#stringTime description#>
    class func stringToTimeStamp(_ stringTime:String) -> Int {
        let arr = stringTime.components(separatedBy: ":")
        var seconds = 0
        if arr.count == 3 {// 时分秒  0:00:00
            if let hour = Int(arr[0]) {
                seconds += hour * 3600
            }
            if let min = Int(arr[1]) {
                seconds += min * 60
            }
            if let sec = Int(arr[2]) {
                seconds += sec
            }
        }else if arr.count == 2{// 时分  00:00
            if let hour = Int(arr[0]) {
                seconds += hour * 3600
            }
            if let min = Int(arr[1]) {
                seconds += min * 60
            }
        }else if arr.count == 1{// 时  00
            if let hour = Int(arr[0]) {
                seconds += hour * 3600
            }
        }
        return seconds
    }
    
    
    /// 距现在多少秒
    /// - Parameter pastDate: <#pastDate description#>
    /// - Parameter currentDate: <#currentDate description#>
    class func timeInterval(_ pastDate:Date, currentDate:Date = Date())->Int{
        return Int(currentDate.timeIntervalSince(pastDate))
    }
    
    
    /// 相差时间超不超过1分钟
    /// - Parameter pastDate: <#pastDate description#>
    /// - Parameter currentDate: <#currentDate description#>
    class func timeOneMinute(_ pastDate:Date, currentDate:Date = Date())->Bool{
        if timeInterval(pastDate, currentDate: currentDate) <= 60 &&
            timeInterval(pastDate, currentDate: currentDate) > 0{
            return true
        }else {
            return false
        }
    }
    
    /// 获取从当天开始指定日期的字符串 (yyyy-MM-dd)
    /// - Parameter day: 指定天数 ，默认为0
    class func getAppointDayString(_ day:Int = 0,_ formStr:String = "yyyyMMdd") -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: day, to: Date())!
        let dateFor = DateFormatter()
        dateFor.dateFormat = formStr
        return dateFor.string(from: date)
    }
}
