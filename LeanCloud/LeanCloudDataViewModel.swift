//
//  LeanCloudDataViewModel.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/10/29.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

let fetchTotalLock = NSLock()
class DataBaseViewModel<T:EventSuperModel> {
    
    class func fetchUserInfo(_ success: @escaping (UserInfoModel)->Void) {
        if let userId = LCApplication.default.currentUser?.objectId?.value {
            let query = LCQuery(className: "UserInfoChart")
            query.whereKey("UserId", .equalTo(userId))
            _ = query.getFirst(completion: { (result) in
                switch result {
                case .success(object: let obj):
                    if let obj = obj as? UserInfoModel {
                        success(obj)
                    }
                case .failure(error: let error):
                    print(error)
                }
            })
        }
    }
    
    class func fetchModel(_ type: EventType,_ searchDateStr:String? = nil,_ success: @escaping (_ arr:[T])->Void) {
        if let userId = LCApplication.default.currentUser?.objectId?.value {
            var arr : [T] = []
            var query : LCQuery
            switch type {
            case .feed:
                query = LCQuery(className: "FeedEventChart")
            case .sleep:
                query = LCQuery(className: "SleepEventChart")
            case .pumpMilk:
                query = LCQuery(className: "PumpMilkEventChart")
            case .diaper:
                query = LCQuery(className: "DiaperEventChart")
            }
            query.whereKey("eventTime", .descending)
            query.whereKey("UserId", .equalTo(userId))
            if let searchDateStr = searchDateStr {
                query.whereKey("currentDateDes", .equalTo(searchDateStr))
            }
            query.limit = 1000
            _ = query.find { (result) in
                switch result {
                case .success(objects: let objs):
                    arr += objs as! [T]
                    success(arr)
                case .failure(error: let error):
                    print(error)
                }
            }
        }
    }
    
    class func fetchTotalCount(_ searchDateStr:String,success: @escaping (Int)->Void) {
        if let userId = LCApplication.default.currentUser?.objectId?.value {
            var totalOperate = 0
            let feedQuery = LCQuery(className: "FeedEventChart")
            feedQuery.whereKey("UserId", .equalTo(userId))
            feedQuery.whereKey("currentDateDes", .equalTo(searchDateStr))
            _ = feedQuery.count { (r) in
                fetchTotalLock.lock()
                totalOperate += r.intValue
                success(totalOperate)
                fetchTotalLock.unlock()
            }
            let diaperQuery = LCQuery(className: "DiaperEventChart")
            diaperQuery.whereKey("UserId", .equalTo(userId))
            diaperQuery.whereKey("currentDateDes", .equalTo(searchDateStr))
            _ = diaperQuery.count { (r) in
                fetchTotalLock.lock()
                totalOperate += r.intValue
                success(totalOperate)
                fetchTotalLock.unlock()
            }
            let pumpQuery = LCQuery(className: "PumpMilkEventChart")
            pumpQuery.whereKey("UserId", .equalTo(userId))
            pumpQuery.whereKey("currentDateDes", .equalTo(searchDateStr))
            _ = pumpQuery.count { (r) in
                fetchTotalLock.lock()
                totalOperate += r.intValue
                success(totalOperate)
                fetchTotalLock.unlock()
            }
            let sleepQuery = LCQuery(className: "SleepEventChart")
            sleepQuery.whereKey("UserId", .equalTo(userId))
            sleepQuery.whereKey("currentDateDes", .equalTo(searchDateStr))
            _ = sleepQuery.count { (r) in
                fetchTotalLock.lock()
                totalOperate += r.intValue
                success(totalOperate)
                fetchTotalLock.unlock()
            }
        }
    }
    
    class func addModel(_ model:T,_ success: (T)->Void){
        if let userId = LCApplication.default.currentUser?.objectId?.value {
            let obj : EventSuperModel = model
            obj.currentDateDes = LCString(TimeFomatChange.getDateString(model.eventTime?.value ?? Date()))
            obj.UserId = LCString(userId)
            if obj.save().isSuccess {
                success(obj as! T)
            }
        }
    }
    
    class func deleteModel(_ obectId:String,_ type: EventType,_ success:@escaping ()->Void) {
        var obj : EventSuperModel
        switch type {
        case .feed:
            obj = FeedEventModel(objectId: obectId)
        case .sleep:
            obj = SleepEventModel(objectId: obectId)
        case .pumpMilk:
            obj = PumpMilkEventModel(objectId: obectId)
        case .diaper:
            obj = DiaperEventModel(objectId: obectId)
        }
        obj.delete { (result) in
            switch result {
            case .success:
                success()
            case .failure(error: let err):
                print(err)
            }
        }
    }
    
    class func updateModel(_ model:T,_ success:@escaping ()->Void) {
        if model.save().isSuccess {
            success()
        }
    }
}
