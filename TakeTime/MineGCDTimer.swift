//
//  MineGCDTimer.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/22.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class MineGCDTimer: NSObject {
    static var codeTimer: DispatchSourceTimer?
    
    class func start(_ timeInterval: TimeInterval = 1,_ totolTimeInterval: TimeInterval = Double(MAXFLOAT), animation: @escaping (_ isFinish: Bool)->()){
        
        var timeCount = totolTimeInterval
        
        MineGCDTimer.codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        MineGCDTimer.codeTimer?.schedule(deadline: .now(), repeating: timeInterval)
        
        var isFinish = false
        
        MineGCDTimer.codeTimer?.setEventHandler(handler: {
            timeCount = timeCount - timeInterval
            if timeCount == 0 {
                MineGCDTimer.codeTimer?.cancel()
                isFinish = true
            }
            DispatchQueue.main.async {
                animation(isFinish)
            }
        })
        MineGCDTimer.codeTimer?.resume()
    }
    
    class func stop() {
        MineGCDTimer.codeTimer?.cancel()
    }
}
