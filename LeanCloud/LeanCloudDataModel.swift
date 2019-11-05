//
//  LeanCloudDataModel.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/10/29.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class UserInfoModel: LCObject {

    @objc dynamic var UserId: LCString?
    @objc dynamic var UserName: LCString?
    @objc dynamic var BabyBirthDate: LCDate?

    override static func objectClassName() -> String {
        return "UserInfoChart"
    }
}


class EventSuperModel: LCObject {
    @objc dynamic var currentDateDes: LCString?
    @objc dynamic var UserId: LCString?
    @objc dynamic var eventTime: LCDate?
}

class SleepEventModel: EventSuperModel {

    @objc dynamic var sleepEndTime: LCDate?
    @objc dynamic var wakeUpStatus: LCNumber?
    @objc dynamic var wakeUpStatusDes: LCString?

    override static func objectClassName() -> String {
        return "SleepEventChart"
    }
}

enum SleepEventEnum : Int{
    case left = 1
    case right = 2
    
    subscript() -> String{
        get {
            switch self{
            case .left:
                return "左"
            case .right:
                return "右"
            }
        }
    }
}

class PumpMilkEventModel: EventSuperModel {

    @objc dynamic var leftAmout: LCNumber?
    @objc dynamic var rightAmout: LCNumber?
    @objc dynamic var tatolAmout: LCNumber?

    override static func objectClassName() -> String {
        return "PumpMilkEventChart"
    }
}

class FeedEventModel: EventSuperModel {

    @objc dynamic var feedOri: LCNumber?

    override static func objectClassName() -> String {
        return "FeedEventChart"
    }
}

class DiaperEventModel: EventSuperModel {

    @objc dynamic var diaperStatus: LCNumber?
    @objc dynamic var diaperStatusDes: LCString?

    override static func objectClassName() -> String {
        return "DiaperEventChart"
    }
}

enum DiaperEventEnum : Int{
    case bianAndNiao = 1
    case bian = 2
    case niao = 3
    case gan = 4
    
    subscript() -> String{
        get {
            switch self{
            case .bianAndNiao:
                return "便便 + 尿尿"
            case .bian:
                return "便便"
            case .niao:
                return "尿尿"
            case .gan:
                return "干"
            }
        }
    }
}

