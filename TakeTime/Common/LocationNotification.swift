//
//  LocationNotification.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/25.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let FeedLocationNotificationSecond = "FeedLocationNotificationSecond"
let FeedLocationNotificationId = "FeedLocationNotificationId"
class LocationNotification {
    typealias notEnable = (Bool)->Void
    
    
    /// 获取推送权限状态
    /// - Parameter statusBlock: <#statusBlock description#>
    class func getNotificationStatus(_ statusBlock:notEnable? = nil) {
        UNUserNotificationCenter.current().getNotificationSettings { (setting) in
            let e = setting.notificationCenterSetting
            if let block = statusBlock {
                block(e == .enabled ? true : false)
            }else{
                if e == .enabled {
                    print("推送已开启")
                }else{
                    print("推送未开启")
                    showAlertView()
                }
            }
        }
    }
    
    
    /// 删除推送
    /// - Parameter noticeId: <#noticeId description#>
    class func removeNotification(_ noticeId:String? = FeedLocationNotificationId) {
        if let id = noticeId {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        }else{
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    
    /// 注册推送
    class func addNotification() {
        getNotificationStatus()
        var second = UserDefaults.standard.integer(forKey: FeedLocationNotificationSecond)
        if second == 0 {
            second = 60 * 8
            UserDefaults.standard.set(60 * 8, forKey: FeedLocationNotificationSecond)
        }
        let content = UNMutableNotificationContent()
        content.title = "喂奶已过\(second / 60)分钟"
        content.subtitle = "所定的喂奶时间已到"
        content.body = "请及时停止防止宝宝吃太撑。如需修改提醒时间，请点击主页右上角进行修改"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(second), repeats: false)
        let request = UNNotificationRequest(identifier: FeedLocationNotificationId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if let _ = err {
                print("发送失败")
            }else{
                print("发送成功")
            }
        }
    }
    
    class func showAlertView() {
        let alert = UIAlertController(title: "通知无授权", message: "未获得通知权限，请前去设置", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: {_ in}))
        alert.addAction(UIAlertAction(title: "前往设置", style: .default) {_ in
            if let url = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        readCurrentController()?.present(alert, animated: true, completion: nil)
    }

}

public func readCurrentController() -> UIViewController? {
    func applicationWindow() -> UIWindow? {
        let windows = UIApplication.shared.windows
        for window in windows {
            if window.windowLevel == .normal{
                return window
            }
        }
        return nil
    }
    var rootVc = applicationWindow()?.rootViewController
    
    if let rootVc_ = rootVc,
        rootVc_.isKind(of: UINavigationController.self) {
        rootVc = (rootVc_ as! UINavigationController).topViewController
    }
    
    while ((rootVc?.presentedViewController) != nil) {
        rootVc = rootVc?.presentedViewController
        if let rootVc_ = rootVc,
            rootVc_.isKind(of: UINavigationController.self) {
            rootVc = (rootVc_ as! UINavigationController).topViewController
        }
    }
    
    if let rootVc_ = rootVc,
        let rootVcNav_ = rootVc_.navigationController {
        while rootVc_.isBeingDismissed ||
            rootVcNav_.isBeingDismissed {
            rootVc = rootVc_.presentedViewController
        }
    }
    
    if let rootVc_ = rootVc,
        rootVc_.isKind(of: UINavigationController.self) {
        rootVc = (rootVc_ as! UINavigationController).topViewController
    }
    
    return rootVc
}
