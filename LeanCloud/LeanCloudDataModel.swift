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
}

class SleepEventModel: EventSuperModel {

    @objc dynamic var sleepStartTime: LCDate?
    @objc dynamic var sleepEndTime: LCDate?
    @objc dynamic var wakeUpStatus: LCNumber?
    @objc dynamic var wakeUpStatusDes: LCString?

    override static func objectClassName() -> String {
        return "SleepEventChart"
    }
}

class PumpMilkEventModel: EventSuperModel {

    @objc dynamic var leftAmout: LCNumber?
    @objc dynamic var rightAmout: LCNumber?
    @objc dynamic var tatolAmout: LCNumber?
    @objc dynamic var eventTime: LCDate?

    override static func objectClassName() -> String {
        return "PumpMilkEventChart"
    }
}

class FeedEventModel: EventSuperModel {

    @objc dynamic var feedOri: LCNumber?
    @objc dynamic var eventTime: LCDate?

    override static func objectClassName() -> String {
        return "FeedEventChart"
    }
}

class DiaperEventModel: EventSuperModel {

    @objc dynamic var diaperStatus: LCNumber?
    @objc dynamic var diaperStatusDes: LCString?
    @objc dynamic var eventTime: LCDate?

    override static func objectClassName() -> String {
        return "DiaperEventChart"
    }
}

