//
//  TodayViewController.swift
//  TakeTimeToday
//
//  Created by 刘恒 on 2019/9/22.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import NotificationCenter
import LeanCloud

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var lblMilk: UILabel!
    @IBOutlet weak var lblDiapre: UILabel!
    @IBOutlet weak var lblWater: UILabel!
    @IBOutlet weak var lblShower: UILabel!
    @IBOutlet weak var btnPushApp: UIButton!
    
    private let dataViewModel = MainVCViewModel()
    override func viewWillAppear(_ animated: Bool) {
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try LCApplication.default.set(id: LeanCloudID, key: LeanCloudKEY, serverURL: LeanCloudServerURL)
            LeanCloudLogin.login()
            customModelRegister()
        } catch {
            print(error)
        }
        fetchFeedData()
        fetchDiaperData()
        fetchSleepData()
        fetchPumpMilkData()
    }
    
    private func customModelRegister() {
        UserInfoModel.register()
        SleepEventModel.register()
        PumpMilkEventModel.register()
        FeedEventModel.register()
        DiaperEventModel.register()
    }
    
    private func fetchFeedData() {
        dataViewModel.fetchFeedModel {[weak self] (t, l, r) in
            guard let `self` = self else{return}
            if let date = self.dataViewModel.arrFeed.first?.eventTime?.value {
                self.lblMilk.text = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(date))
            }else{
                self.lblMilk.text = "00:00"
            }
        }
    }
    
    private func fetchDiaperData() {
        dataViewModel.fetchDiaperModel {[weak self] (t, bAntN, b, n, g) in
            guard let `self` = self else{return}
            if let date = self.dataViewModel.arrDiaper.first?.eventTime?.value {
                self.lblDiapre.text = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(date))
            }else{
                self.lblDiapre.text = "00:00"
            }
        }
    }
    
    private func fetchSleepData() {
        dataViewModel.fetchSleepModel {[weak self] (t, s) in
            guard let `self` = self else{return}
            if let total = t {
                self.lblWater.text = "已睡\(total/60)分钟"
            }
            if let _ = s {
                self.lblWater.text = "还没醒"
            }
        }
    }
    
    private func fetchPumpMilkData() {
        dataViewModel.fetchPumpMilk {[weak self] (t) in
            guard let `self` = self else{return}
            if let date = self.dataViewModel.arrPump.first?.eventTime?.value {
                self.lblShower.text = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(date))
            }else{
                self.lblShower.text = "00:00"
            }
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact{
            btnPushApp.isHidden = true
            preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 140)
        }else{
            btnPushApp.isHidden = false
            preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 160)
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func didPressDiaper(_ sender: Any) {
        extensionContext?.open(URL(string: "TodayWidget://diaper")!, completionHandler: { _ in })
    }
    
    @IBAction func didPressMilk(_ sender: Any) {
        extensionContext?.open(URL(string: "TodayWidget://feed")!, completionHandler: { _ in })
    }
    
    @IBAction func didPressShower(_ sender: Any) {
        extensionContext?.open(URL(string: "TodayWidget://pumpMilk")!, completionHandler: { _ in })
    }
    
    @IBAction func didPressWater(_ sender: Any) {
        extensionContext?.open(URL(string: "TodayWidget://sleep")!, completionHandler: { _ in })
    }
    
    @IBAction func didPressOpenApp(_ sender: Any) {
        extensionContext?.open(URL(string: "TodayWidget://")!, completionHandler: { _ in })
    }
}
