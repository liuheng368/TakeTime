//
//  AppDelegate.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/21.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            try LCApplication.default.set(id: LeanCloudID, key: LeanCloudKEY, serverURL: LeanCloudServerURL)
            LeanCloudLogin.login()
            customModelRegister()
        } catch {
            print(error)
        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //本地推送注册
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { (status, err) in
            if let _ = err {
                print(err!)
            }
        }
        return true
    }
    
    private func customModelRegister() {
        UserInfoModel.register()
        EventSuperModel.register()
        SleepEventModel.register()
        PumpMilkEventModel.register()
        FeedEventModel.register()
        DiaperEventModel.register()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.beginBackgroundTask {
            UIApplication.shared.endBackgroundTask(.invalid)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "TodayWidget"{
            let str = url.absoluteString.components(separatedBy: "//")[1]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TodayWeightNotificationKey), object: str)
        }
        return true
    }
}

