//
//  RecordListHeaderView.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/7.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let RecordListHeaderViewId = "RecordListHeaderView"

class RecordListHeaderView: UITableViewHeaderFooterView {

    public var randomColor : UIColor?{
        didSet{
            if let rc = randomColor {
                vTop.backgroundColor = rc
                vCenter.backgroundColor = rc
                vBottom.backgroundColor = rc
            }
        }
    }
    
    public var data : OneDayTotalModel? {
        didSet{
            if let d = data {
                if let arrFeed = d[.feed] as? [FeedEventModel] {
                    lblFeed.text = "喂奶共\(arrFeed.count)次;\n其中左:\(arrFeed.filter{$0.feedOri?.value==1}.count)次,右:\(arrFeed.filter{$0.feedOri?.value==2}.count)次"
                    lblDay.text = TimeFomatChange.getDateString((arrFeed.first?.eventTime!.value)!, "dd日")
                    lblMonth.text = TimeFomatChange.getDateString((arrFeed.first?.eventTime!.value)!, "MM月")
                }else{lblFeed.text = ""}
                if let arrDiaper = d[.diaper] as? [DiaperEventModel] {
                    lblDiaper.text = "换尿布共\(arrDiaper.count)次;\n其中便尿\(arrDiaper.filter{$0.diaperStatus==1}.count)次,便便\(arrDiaper.filter{$0.diaperStatus==2}.count)次,尿尿\(arrDiaper.filter{$0.diaperStatus==3}.count)次,干爽\(arrDiaper.filter{$0.diaperStatus==4}.count)次"
                    lblDay.text = TimeFomatChange.getDateString((arrDiaper.first?.eventTime!.value)!, "dd日")
                    lblMonth.text = TimeFomatChange.getDateString((arrDiaper.first?.eventTime!.value)!, "MM月")
                }else{lblDiaper.text = ""}
                if let arrSleep = d[.sleep] as? [SleepEventModel] {
                    let total = arrSleep.reduce(0) { (res, model) -> Int in
                        if let end = model.sleepEndTime?.value,
                            let start = model.eventTime?.value{
                            return res + TimeFomatChange.timeInterval(start, currentDate: end)
                        }
                        return res
                    }
                    lblSleep.text = "已睡\(total / 3600)小时\(total % 3600 / 60)分钟;\n其中饿醒\(arrSleep.filter{$0.wakeUpStatus==1}.count)次,惊醒\(arrSleep.filter{$0.wakeUpStatus==2}.count)次,叫醒\(arrSleep.filter{$0.wakeUpStatus==3}.count)次,自然醒\(arrSleep.filter{$0.wakeUpStatus==4}.count)次"
                    lblDay.text = TimeFomatChange.getDateString((arrSleep.first?.eventTime!.value)!, "dd日")
                    lblMonth.text = TimeFomatChange.getDateString((arrSleep.first?.eventTime!.value)!, "MM月")
                }else{lblSleep.text = ""}
                if let arrPump = d[.pumpMilk] as? [PumpMilkEventModel] {
                    lblPump.text = "泵奶\(arrPump.reduce(0, {$0 + $1.totalAmout!.value}))ml;\n其中左\(arrPump.reduce(0, {$0 + $1.leftAmout!.value}))ml,右\(arrPump.reduce(0, {$0 + $1.rightAmout!.value}))ml"
                    lblDay.text = TimeFomatChange.getDateString((arrPump.first?.eventTime!.value)!, "dd日")
                    lblMonth.text = TimeFomatChange.getDateString((arrPump.first?.eventTime!.value)!, "MM月")
                }else{lblPump.text = ""}
            }
        }
    }
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var vCenter: UIView!
    @IBOutlet weak var vBottom: UIView!
    @IBOutlet weak var vBG: UIView!
    @IBOutlet weak var lblFeed: UILabel!
    @IBOutlet weak var lblDiaper: UILabel!
    @IBOutlet weak var lblSleep: UILabel!
    @IBOutlet weak var lblPump: UILabel!
    
    override func awakeFromNib() {
        vCenter.layer.cornerRadius = 7
        lblFeed.textColor = feedStartBGcolor
        lblDiaper.textColor = diaperStartBGcolor
        lblSleep.textColor = sleepStartBGcolor
        lblPump.textColor = pumpMilkStartBGcolor
        vBG.layer.cornerRadius = 4
        vBG.layer.shadowColor = UIColor.black.cgColor
        vBG.layer.shadowOffset = CGSize(width: 0, height: 0)
        vBG.layer.shadowOpacity = 0.4
        vBG.layer.shadowRadius = 4
        contentView.backgroundColor = RecordBGColor
    }
}
