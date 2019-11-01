//
//  MainVCViewModel.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/1.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class MainVCViewModel: NSObject {
    var arrFeed : [FeedEventModel] = []
    var arrSleep : [SleepEventModel] = []
    var arrPump : [PumpMilkEventModel] = []
    var arrDiaper : [DiaperEventModel] = []
    
    var currentDateStr : String {
        get{TimeFomatChange.getAppointDayString()}
    }
    
    func fetchFeedModel(_ success: @escaping (_ total:Int,_ left:Int,_ right:Int)->Void ) {
        DataBaseViewModel.fetchModel(.feed, currentDateStr) {[weak self] (arr) in
            guard let `self` = self else{return}
            if let arr = arr as? [FeedEventModel] {
                self.arrFeed = arr
                let res = arr.reduce((0,0,0)) { (r, model) -> (Int,Int,Int) in
                    var left = 0,right = 0
                    if model.feedOri == 1 {
                        left = r.1 + 1
                    }else if model.feedOri == 2 {
                        right = r.2 + 1
                    }
                    return (r.0 + 1,left,right)
                }
                success(res.0,res.1,res.2)
            }
        }
    }
    
    func fetchDiaperModel(_ success: @escaping (_ total:Int,_ bAndN:Int,_ bian:Int,_ niao:Int,_ gan:Int)->Void ) {
        DataBaseViewModel.fetchModel(.diaper, currentDateStr) {[weak self] (arr) in
            guard let `self` = self else{return}
            if let arr = arr as? [DiaperEventModel] {
                self.arrDiaper = arr
                let res = arr.reduce((0,0,0,0,0)) { (r, model) -> (Int,Int,Int,Int,Int) in
                    var bAndn = 0,bian = 0,niao = 0,gan = 0
                    if model.diaperStatus == 1 {
                        bAndn = r.1 + 1
                    }else if model.diaperStatus == 2 {
                        bian = r.2 + 1
                    }else if model.diaperStatus == 3 {
                        niao = r.3 + 1
                    }else if model.diaperStatus == 4 {
                        gan = r.4 + 1
                    }
                    return (r.0 + 1,bAndn,bian,niao,gan)
                }
                success(res.0,res.1,res.2,res.3,res.4)
            }
        }
    }
    
    func fetchSleepModel(_ success: @escaping (_ total:Int?,_ sleeping:String?)->Void ) {
        DataBaseViewModel.fetchModel(.sleep, currentDateStr) {[weak self] (arr) in
            guard let `self` = self else{return}
            if let arr = arr as? [SleepEventModel] {
                self.arrSleep = arr
                if let first = arr.first {
                    if let _ = first.sleepEndTime {
                        let res = arr.reduce(0) { (r, model) -> Int in
                            if let startTime = model.sleepStartTime?.value,
                                let endTime = model.sleepEndTime?.value {
                                return (TimeFomatChange.timeInterval(startTime, currentDate: endTime) + r)
                            }
                            return r
                        }
                        success(res,nil)
                    }else{
                        let dateFor = DateFormatter()
                        dateFor.dateFormat = "MM-dd HH:mm"
                        if let startTime = first.sleepStartTime?.value {
                            success(nil,dateFor.string(from: startTime))
                        }
                        success(nil,dateFor.string(from: Date()))
                    }
                }
            }
        }
    }
    
    func fetchPumpMilk(_ success: @escaping (Int)->Void) {
        DataBaseViewModel.fetchModel(.pumpMilk, currentDateStr) {[weak self] (arr) in
            guard let `self` = self else{return}
            if let arr = arr as? [PumpMilkEventModel]{
                self.arrPump = arr
                let res = arr.reduce(0) { (r, model) -> Double in
                    if let t = model.tatolAmout?.value {
                        return (r + t)
                    }
                    return r
                }
                success(Int(res))
            }
        }
    }
}
    

