//
//  MainBmobModel.swift
//  TakeTimeToday
//
//  Created by 刘恒 on 2019/9/28.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

struct MainBmobModel {
    public var eventDate: Date
    public var eventType: EventType
    public var eventTypeDes: String
    
    init(eventDate:Date,eventType:EventType,eventTypeDes:String) {
        self.eventDate = eventDate
        self.eventType = eventType
        self.eventTypeDes = eventTypeDes
    }
}
