//
//  TotalDataViewModel.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/6.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class TotalDataViewModel: NSObject {
    typealias OneDayTotalModel = [EventType:[EventSuperModel]]
    
    func fetchTotalData(_ success: @escaping ([OneDayTotalModel])->Void) {
        var arrTotal : [EventSuperModel] = []
        NSLog("df")
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
    
    func dateHandle(_ arr:[EventSuperModel],_ success: @escaping ([OneDayTotalModel])->Void) {
        if arr.count <= 0 {return}
        NSLog("df")
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
            var arrFinsh : [OneDayTotalModel] = []
            arrNew.forEach { (a) in
                var dic : OneDayTotalModel = OneDayTotalModel()
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
                }
                arrFinsh.append(dic)
            }
            DispatchQueue.main.async {
                NSLog("df")
                success(arrFinsh)
            }
        }
    }
}
