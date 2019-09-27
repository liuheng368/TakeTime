//
//  EventModel+CoreDataProperties.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/25.
//  Copyright © 2019 刘恒. All rights reserved.
//
//

import Foundation
import CoreData


extension EventModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventModel> {
        return NSFetchRequest<EventModel>(entityName: "EventModel")
    }

    @NSManaged public var eventDate: NSDate?
    @NSManaged public var eventType: Int16

}
