//
//  AppDelegate.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/21.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

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
            
        }
        return true
    }
}

