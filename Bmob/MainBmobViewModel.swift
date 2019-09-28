//
//  MainBmobViewModel.swift
//  TakeTimeToday
//
//  Created by 刘恒 on 2019/9/28.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class MainBmobViewModel: NSObject {
    class func fetchEnent(_ type: EventType,success:@escaping ([MainBmobModel])->Void) {
        let query:BmobQuery = BmobQuery(className: "eventModel")
        query.whereKey("eventType", equalTo: type.rawValue)
        query.findObjectsInBackground { (array, error) in
            if let arr = array {
                var arrModel : [MainBmobModel] = []
                arr.forEach({ (mod) in
                    if let obj = mod as? BmobObject,
                        let eventTypeDes = obj.object(forKey: "eventTypeDes") as? String,
                        let date = obj.object(forKey: "eventTime") as? Date{
                        arrModel.append(MainBmobModel(eventDate: date,
                                                      eventType: type,
                                                      eventTypeDes: eventTypeDes))
                    }
                })
                success(arrModel)
            }
        }
    }
    
    class func add(_ eventTime:Date,_ eventType:EventType,success:@escaping (MainBmobModel)->Void){
        let gamescore:BmobObject = BmobObject(className: "eventModel")
        gamescore.setObject(eventType.rawValue, forKey: "eventType")
        gamescore.setObject(eventType[], forKey: "eventTypeDes")
        gamescore.setObject(eventTime, forKey: "eventTime")
        gamescore.saveInBackground { (b, error) in
            if let _ = error {return}
            success(MainBmobModel(eventDate: eventTime,
                                  eventType: eventType,
                                  eventTypeDes: eventType[]))
        }
    }
}
