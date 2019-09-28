//
//  MainViewModel.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/22.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import CoreData

let EntityEventName = "EventModel"
class MainViewModel: NSObject {
    
    class func fetchEnent(_ type: EventType) -> [EventModel] {
        let entity = NSEntityDescription.entity(forEntityName: EntityEventName, in:CoreDataShare.managerContext)
        let predicate = NSPredicate(format: "eventType=\(type.rawValue)", argumentArray: nil)
        //创建请求
        let request = NSFetchRequest<EventModel>()
        request.entity = entity
        request.predicate = predicate
        var fetchObjects:[EventModel] = []
        do {
            fetchObjects = try CoreDataShare.managerContext.fetch(request)
            return fetchObjects
        } catch {
            print("查询失败")
        }
        return fetchObjects
    }
    
    class func add(_ eventType:EventType, _ eventData:Date){
        let event:EventModel = NSEntityDescription.insertNewObject(forEntityName: EntityEventName, into: CoreDataShare.managerContext) as! EventModel
        event.eventDate = eventData as NSDate
        event.eventType = Int16(eventType.rawValue)
        CoreDataShare.save()
        
        let gamescore:BmobObject = BmobObject(className: "eventModel")
        gamescore.setObject(eventData, forKey: "eventTime")
        gamescore.setObject(eventType.rawValue, forKey: "eventType")
        gamescore.setObject(eventType[], forKey: "eventTypeDes")
        gamescore.saveInBackground { (b, error) in
            if let err = error{
                print("error is \(err.localizedDescription)")
            }else{
                print("success")
            }
        }
    }
    
}

enum EventType : Int{
    case Water = 1
    case Milk
    case Diaper
    case Shower
    
    subscript () ->String {
        get{
            switch self {
            case .Water:
                return "喝水"
            case .Milk:
                return "喝奶"
            case .Diaper:
                return "换尿布"
            case .Shower:
                return "洗澡"
            }
        }
    }
}
