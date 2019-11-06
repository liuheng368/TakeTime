//
//  MainViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/21.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class MainViewController: UIViewController {
    
    private let dataViewModel = MainVCViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeActive()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        becomeDeath()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册进入前台的通知
        NotificationCenter.default.addObserver(self, selector:#selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        //注册进入后台的通知
        NotificationCenter.default.addObserver(self, selector:#selector(becomeDeath), name: UIApplication.willResignActiveNotification, object: nil)
        pageUIInit()
        showWeatherWithFrame()
        fetchUserInfo()
    }
    
    //MARK: Point Event
    @IBAction func didPressFeed(_ sender: Any) {
        let feedVc = FeedAppendViewController(nibName: "FeedAppendViewController", bundle: nil)
        feedVc.modalPresentationStyle = .fullScreen
        feedVc.finishBlock = {[weak self] in
            guard let `self` = self else{return}
            self.fetchFeedData()
        }
        self.present(feedVc, animated: true, completion: nil)
    }
    
    @IBAction func didPressDiaper(_ sender: Any) {
        let diaperVC = DiaperAppendViewController(nibName: "DiaperAppendViewController", bundle: nil)
        diaperVC.modalPresentationStyle = .fullScreen
        diaperVC.finishBlock = {[weak self] in
            guard let `self` = self else{return}
            self.fetchDiaperData()
        }
        self.present(diaperVC, animated: true, completion: nil)
    }
    
    @IBAction func didPressSleep(_ sender: Any) {
        let sleepVC = SleepAppendViewController(nibName: "SleepAppendViewController", bundle: nil)
        sleepVC.modalPresentationStyle = .fullScreen
        sleepVC.finishBlock = {[weak self] in
            guard let `self` = self else{return}
            self.fetchSleepData()
        }
        if dataViewModel.arrSleep.first?.sleepEndTime?.value == nil {
            sleepVC.currentModel = dataViewModel.arrSleep.first
        }
        self.present(sleepVC, animated: true, completion: nil)
    }
    
    @IBAction func didPressPumpMilk(_ sender: Any) {
        let pumpMilkVC = PumpMilkAppendViewController(nibName: "PumpMilkAppendViewController", bundle: nil)
        pumpMilkVC.modalPresentationStyle = .fullScreen
        pumpMilkVC.finishBlock = {[weak self] in
            guard let `self` = self else{return}
            self.fetchPumpMilkData()
        }
        pumpMilkVC.arrPump = dataViewModel.arrPump
        self.present(pumpMilkVC, animated: true, completion: nil)
    }
    
    @IBAction func didPressRecord(_ sender: Any) {
        
    }
    
    @IBAction func didPressClock(_ sender: Any) {
        
    }
    
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivHeadImg: UIImageView!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var vWeather: UIView!
    
    //feed
    @IBOutlet weak var vFeed: UIView!
    @IBOutlet weak var bgFeed: UIImageView!
    @IBOutlet weak var lblFeedDes: UILabel!
    @IBOutlet weak var lblFeedTime: UILabel!
    
    //diaper
    @IBOutlet weak var vDiaper: UIView!
    @IBOutlet weak var bgDiaper: UIImageView!
    @IBOutlet weak var lblDiaperTime: UILabel!
    @IBOutlet weak var lblDiaperDes: UILabel!
    
    //sleep
    @IBOutlet weak var vSleep: UIView!
    @IBOutlet weak var bgSleep: UIImageView!
    @IBOutlet weak var lblSleepTime: UILabel!
    @IBOutlet weak var lblSleepDes: UILabel!
    
    //pumpMilk
    @IBOutlet weak var vPumpMilk: UIView!
    @IBOutlet weak var bgPumpMilk: UIImageView!
    @IBOutlet weak var lblPumpMilkDes: UILabel!
    @IBOutlet weak var lblPumpMilkTime: UILabel!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: 倒计时相关
extension MainViewController{
    
    @objc  func becomeActive(){
        MineGCDTimer.start {[weak self] _ in
            guard let `self` = self else{return}
            self.timerPass()
        }
    }
    
    @objc  func becomeDeath(){
        MineGCDTimer.stop()
    }
    
    private func timerPass() {
        if let model = dataViewModel.arrDiaper.first,
            let date = model.eventTime?.value{
            lblDiaperTime.text = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(date))
        }else{
            lblDiaperTime.text = "00:00"
        }
        if let model = dataViewModel.arrFeed.first,
            let date = model.eventTime?.value{
            lblFeedTime.text = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(date))
        }else{
            lblFeedTime.text = "00:00"
        }
        if let model = dataViewModel.arrPump.first,
            let date = model.eventTime?.value{
            lblPumpMilkTime.text = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(date))
        }else{
            lblPumpMilkTime.text = "00:00"
        }
        if let model = dataViewModel.arrSleep.first,
            let date = model.eventTime?.value{
            if let _ = model.sleepEndTime {
                lblSleepTime.text = "00:00"
            }else{
                lblSleepTime.text = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(date))
            }
        }else{
            lblSleepTime.text = "00:00"
        }
    }
}

//MARK: 页面请求相关
extension MainViewController {
    
    private func fetchUserInfo() {
        DataBaseViewModel.fetchUserInfo({[weak self] (model) in
            guard let `self` = self else{return}
            self.lblName.text = model.UserName?.value
            self.lblBirthday.text = "已经出生\((TimeFomatChange.timeInterval(model.BabyBirthDate!.value) / (60 * 60 * 24)))天了！"
            self.fetchAllData()
        })
    }
    
    private func fetchOperateTotal() {
        self.dataViewModel.fetchOperateTotal {[weak self] (i) in
            guard let `self` = self else{return}
            self.btnRecord.setTitle("今日共产生\(i)条记录", for: .normal)
        }
    }
    
    private func fetchAllData() {
        fetchFeedData()
        fetchDiaperData()
        fetchSleepData()
        fetchPumpMilkData()
        //避免线程拥堵
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchOperateTotal()
        }
    }
    
    private func fetchFeedData() {
        dataViewModel.fetchFeedModel {[weak self] (t, l, r) in
            guard let `self` = self else{return}
            self.lblFeedDes.text = "今日共喂奶\(t)次(左\(l)次,右\(r)次)"
        }
    }
    
    private func fetchDiaperData() {
        dataViewModel.fetchDiaperModel {[weak self] (t, bAntN, b, n, g) in
            guard let `self` = self else{return}
            self.lblDiaperDes.text = "今日共换尿布\(t)次(便尿\(bAntN)次,便\(b)次,尿\(n)次)"
        }
    }
    
    private func fetchSleepData() {
        dataViewModel.fetchSleepModel {[weak self] (t, s) in
            guard let `self` = self else{return}
            if let total = t {
                self.lblSleepDes.text = "今日已睡\(total / 3600)小时\(total % 3600 / 60)分钟"
            }
            if let sleeping = s {
                self.lblSleepDes.text =  "\(sleeping)入睡,还未醒"
            }
        }
    }
    
    private func fetchPumpMilkData() {
        dataViewModel.fetchPumpMilk {[weak self] (t) in
            guard let `self` = self else{return}
            self.lblPumpMilkDes.text = "已泵奶\(Int(t))ml"
        }
    }
}

//MARK: 页面展示相关
extension MainViewController {
    private func pageUIInit() {
        ivHeadImg.layer.cornerRadius = 40
        ivHeadImg.layer.borderWidth = 1
        ivHeadImg.layer.borderColor = UIColor.white.cgColor
        btnRecord.layer.cornerRadius = 22
        bgFeed.image = GradientBGColor.setGradientBackgroundColors(.feed)
        bgDiaper.image = GradientBGColor.setGradientBackgroundColors(.diaper)
        bgSleep.image = GradientBGColor.setGradientBackgroundColors(.sleep)
        bgPumpMilk.image = GradientBGColor.setGradientBackgroundColors(.pumpMilk)
        vFeed.layer.cornerRadius = 8
        vDiaper.layer.cornerRadius = 8
        vSleep.layer.cornerRadius = 8
        vPumpMilk.layer.cornerRadius = 8
    }
    
    func showWeatherWithFrame() {
        let weatherView = HeFengPluginView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), viewType: .leftLarge, userKey: "d4d211b3144548898f1ffb833c9222eb", location: "")
        let leftModel = HeFengConfigModel()
        leftModel.iconSize = 30
        leftModel.type = .weatherStateIcon
        let rightModel = HeFengConfigModel()
        rightModel.textFont = UIFont.systemFont(ofSize: 16)
        rightModel.textColor = UIColor.white
        rightModel.type = .temp
        let bottonModel = HeFengConfigModel()
        bottonModel.iconSize = 12
        bottonModel.textFont = UIFont.systemFont(ofSize: 16)
        bottonModel.textColor = UIColor.white
        bottonModel.type = .weatherState
        weatherView?.configArray = [[leftModel], [rightModel], [bottonModel]]
        weatherView?.contentViewAlignmen = .center
        weatherView?.padding = UIEdgeInsets.zero
        weatherView?.themType = .light
        weatherView?.isShowBorder = false
        weatherView?.backgroundColor = UIColor.clear
        weatherView?.isUserInteractionEnabled = false
        vWeather.addSubview(weatherView!)
    }
}
