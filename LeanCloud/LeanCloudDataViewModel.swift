//
//  LeanCloudDataViewModel.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/10/29.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

struct DataBaseViewModel<T:EventSuperModel> {
    
    func fetchUserInfo(_ success: @escaping (UserInfoModel)->Void) {
        if let userId = LCApplication.default.currentUser?.objectId?.value {
            let query = LCQuery(className: "UserInfoChart")
            query.whereKey(userId, .equalTo("UserId"))
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
    
    func fetchModel(_ type: EventType,_ searchDateStr:String,_ success: @escaping (_ arr:[T])->Void) {
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
            query.whereKey(userId, .equalTo("UserId"))
            query.whereKey(searchDateStr, .equalTo("currentDateDes"))
            query.limit = 1000
            _ = query.find { (result) in
                switch result {
                case .success(objects: let objs):
                    for obj in objs {
                        arr.append(obj as! T)
                    }
                    success(arr)
                case .failure(error: let error):
                    print(error)
                }
            }
        }
    }
    
    func addModel(_ model:T,_ success: ()->Void){
        if let userId = LCApplication.default.currentUser?.objectId?.value {
            let obj : EventSuperModel = model
            obj.eventTime = model.eventTime
            obj.currentDateDes = LCString(TimeFomatChange.getDateString(model.eventTime?.value ?? Date()))
            obj.UserId = LCString(userId)
            if obj.save().isSuccess {
                success()
            }
        }
    }
    
    func deleteModel(_ obectId:String,_ type: EventType,_ success:@escaping ()->Void) {
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
    
    func updateModel(_ model:T,_ success:@escaping ()->Void) {
        if model.save().isSuccess {
            success()
        }
    }
}
