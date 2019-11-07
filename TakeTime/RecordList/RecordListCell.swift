//
//  RecordListCell.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/7.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let RecordListCellId = "RecordListCell"
class RecordListCell: UITableViewCell {

    public var randomColor : UIColor?{
        didSet{
            if let rc = randomColor {
                vBottom.backgroundColor = rc
            }
        }
    }
    
    public var data : EventSuperModel? {
        didSet{
            if let d = data {
                lblTime.text = TimeFomatChange.getDateString(d.eventTime!.value, "HH:mm")
                if let obj = d as? FeedEventModel {
                    lblDesc.textColor = feedStartBGcolor
                    lblDesc.text = "本次喂奶开始侧\(FeedEventEnum(rawValue: Int(obj.feedOri!.value))![])"
                }
                if let obj = d as? DiaperEventModel {
                    lblDesc.textColor = diaperStartBGcolor
                    lblDesc.text = "本次换尿布时尿布状态:\(DiaperEventEnum(rawValue: Int(obj.diaperStatus!.value))![])"
                }
                if let obj = d as? SleepEventModel {
                    lblDesc.textColor = sleepStartBGcolor
                    let start = obj.eventTime!.value, end = obj.sleepEndTime!.value
                    let total = TimeFomatChange.timeInterval(start, currentDate: end)
                    lblDesc.text = "本次睡觉从\(TimeFomatChange.getDateString(start, "HH:mm"))到\(TimeFomatChange.getDateString(end, "HH:mm")),共\(total / 3600)小时\(total % 3600 / 60)分钟;因为\(SleepEventEnum(rawValue: Int(obj.wakeUpStatus!.value))![])"
                }
                if let obj = d as? PumpMilkEventModel {
                    lblDesc.textColor = pumpMilkStartBGcolor
                    lblDesc.text = "本次泵奶左侧\(obj.leftAmout!.value)ml,右侧\(obj.rightAmout!.value)ml,共\(obj.totalAmout!.value)ml"
                }
            }
        }
    }
    
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var vBottom: UIView!
    @IBOutlet weak var lblTime: UILabel!
}
