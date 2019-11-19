//
//  TotalDataViewModel.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/6.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

typealias OneDayTotalModel = [EventType:[EventSuperModel]]
class TotalDataViewModel: NSObject {
    var arrDate : [OneDayTotalModel] = []
    var arrSequence : [[EventSuperModel]] = []
    
    func fetchTotalData(_ success: @escaping ()->Void) {
        var arrTotal : [EventSuperModel] = []
        DataBaseViewModel.fetchModel(.feed) { (a) in
            arrTotal += a
            DataBaseViewModel.fetchModel(.diaper) { (ar) in
                arrTotal += ar
                DataBaseViewModel.fetchModel(.pumpMilk) { (arr) in
                    arrTotal += arr
                    DataBaseViewModel.fetchModel(.sleep) {[weak self] (arra) in
                        guard let `self` = self else{return}
                        arrTotal += arra
                        self.dateHandle(arrTotal, success)
                    }
                }
            }
        }
    }
    
    func dateHandle(_ arr:[EventSuperModel],_ success: @escaping ()->Void) {
        if arr.count <= 0 {return}
        DispatchQueue.global().async {
            var arrOld = arr
            var arrNew : [[EventSuperModel]] = []
            while arrOld.count > 0 {
                if let objFir = arrOld.first,
                    let dateDes = objFir.currentDateDes?.value {
                    arrNew.append(arrOld.filter { $0.currentDateDes?.value == dateDes})
                    arrOld = arrOld.filter { $0.currentDateDes?.value != dateDes}
                }
            }
            arrNew.forEach { (a) in
                var dic : OneDayTotalModel = OneDayTotalModel()
                var arrSeq : [EventSuperModel] = []
                a.forEach { (model) in
                    if model is FeedEventModel {
                        if let _ = dic[.feed] {}else{
                            dic[.feed] = []
                        }
                        dic[.feed]?.append(model as! FeedEventModel)
                    }else if model is DiaperEventModel {
                        if let _ = dic[.diaper] {}else{
                            dic[.diaper] = []
                        }
                        dic[.diaper]?.append(model as! DiaperEventModel)
                    }else if model is SleepEventModel {
                        if let _ = dic[.sleep] {}else{
                            dic[.sleep] = []
                        }
                        dic[.sleep]?.append(model as! SleepEventModel)
                    }else if model is PumpMilkEventModel {
                        if let _ = dic[.pumpMilk] {}else{
                            dic[.pumpMilk] = []
                        }
                        dic[.pumpMilk]?.append(model as! PumpMilkEventModel)
                    }
                    arrSeq.append(model)
                }
                arrSeq.sort { $0.eventTime!.value > $1.eventTime!.value }
                self.arrSequence.append(arrSeq)
                self.arrDate.append(dic)
            }
            DispatchQueue.main.async {
                success()
            }
        }
    }
}
