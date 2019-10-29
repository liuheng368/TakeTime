//
//  MainBmobViewModel.swift
//  TakeTimeToday
//
//  Created by 刘恒 on 2019/9/28.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit


class MainBmobViewModel: NSObject {
    class func fetchEnent(_ type: NSObject,success:@escaping ([NSObject])->Void) {
//        let query:BmobQuery = BmobQuery(className: "eventModel")
//        query.whereKey("eventType", equalTo: type.rawValue)
//        query.order(byDescending: "eventTime")
//        query.findObjectsInBackground { (array, error) in
//            if let arr = array {
//                var arrModel : [MainBmobModel] = []
//                arr.forEach({ (mod) in
//                    if let obj = mod as? BmobObject,
//                        let eventTypeDes = obj.object(forKey: "eventTypeDes") as? String,
//                        let date = obj.object(forKey: "eventTime") as? Date,
//                        let id = obj.object(forKey: "objectId") as? String{
//                        arrModel.append(MainBmobModel(eventDate: date,
//                                                      eventType: type,
//                                                      eventTypeDes: eventTypeDes,
//                                                      objectId: id))
//                    }
//                })
//                success(arrModel)
//            }
//        }
    }
    
    class func add(_ eventTime:Date,_ eventType:NSObject,success:@escaping (NSObject)->Void){
//        let gamescore:BmobObject = BmobObject(className: "eventModel")
//        gamescore.setObject(eventType.rawValue, forKey: "eventType")
//        gamescore.setObject(eventType[], forKey: "eventTypeDes")
//        gamescore.setObject(eventTime, forKey: "eventTime")
//        gamescore.saveInBackground { (b, error) in
//            if let _ = error {return}
//            success(MainBmobModel(eventDate: eventTime,
//                                  eventType: eventType,
//                                  eventTypeDes: eventType[]))
        }
    
    class func delete(_ objectId : String, success:@escaping ()->()) {
//        let gamescore:BmobObject = BmobObject(outDataWithClassName: "eventModel", objectId: objectId)
//        gamescore.deleteInBackground { (b, e) in
//            if let e = e {
//                print(e)
//            }else{
//                success()
//            }
//        }
    }
}
