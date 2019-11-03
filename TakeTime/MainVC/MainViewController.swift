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

    
    private let dataViewModel = MainVCViewModel()
    private var vcTimePass : (feed:Int,diapre:Int,sleep:Int,pumpMilk:Int) = (Int.min,Int.min,Int.min,Int.min)
    private var initialTimer : (feed:String,diapre:String,sleep:String,pumpMilk:String) = ("","","","")
    private var bubbleTransition : HYBBubbleTransition?
    
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
        let vc = FeedAppendViewController(nibName: "FeedAppendViewController", bundle: nil)
        vc.modalPresentationStyle = .custom
        vc.finishBlock = {[weak self] (model) in
            guard let `self` = self else{return}
            self.timerTitleInit(.feed, model.eventTime!.value)
        }
        bubbleTransition = HYBBubbleTransition(presented: { (presented, presenting, source, transition) in
            if let bubble = transition as? HYBBubbleTransition{
                bubble.bubbleColor = UIColor.red
                bubble.bubbleStartPoint = CGPoint(x: self.view.center.x, y: self.view.frame.maxY)
                bubble.duration = 0.2
            }
        }) { (dismissed, transition) in
            transition?.transitionMode = .dismiss
        }
        vc.transitioningDelegate = bubbleTransition
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didPressDiaper(_ sender: Any) {
    }
    
    @IBAction func didPressSleep(_ sender: Any) {
    }
    
    @IBAction func didPressPumpMilk(_ sender: Any) {
    }
    
    @IBAction func didPressRecord(_ sender: Any) {
    }
    
    @IBAction func didPressClock(_ sender: Any) {
    }
//    @IBAction func didPressWater(_ sender: Any) {
//        MainBmobViewModel.add(Date(), .Water, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.vcTimePass.water = 0
//            self.timerTitleInit(.Water, model.eventDate)
//        })
//    }
    
//    @IBAction func didPressMilk(_ sender: Any) {
//        MainBmobViewModel.add(Date(), .Milk, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.vcTimePass.milk = 0
//            self.timerTitleInit(.Milk, model.eventDate)
//        })
//    }
    
//    @IBAction func didPressDiaper(_ sender: Any) {
//        MainBmobViewModel.add(Date(), .Diaper, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.vcTimePass.diapre = 0
//            self.timerTitleInit(.Diaper, model.eventDate)
//        })
//    }
    
//    @IBAction func didPressShower(_ sender: Any) {
//        MainBmobViewModel.add(Date(), .Shower, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.vcTimePass.shower = 0
//            self.timerTitleInit(.Shower, model.eventDate)
//        })
//    }
    
    //MARK: Look For List
//    @IBAction func didPressMilkList(_ sender: Any) {
//        let vc = EventTableViewController()
////        vc.vcType = .Milk
//        let nav = UINavigationController(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
//    }
//
//    @IBAction func didPressDiaperList(_ sender: Any) {
//        let vc = EventTableViewController()
////        vc.vcType = .Diaper
//        let nav = UINavigationController(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
//    }
//
//    @IBAction func didPressWaterList(_ sender: Any) {
//        let vc = EventTableViewController()
////        vc.vcType = .Water
//        let nav = UINavigationController(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
//    }
    
//    @IBAction func didPressShowerList(_ sender: Any) {
//        let vc = EventTableViewController()
////        vc.vcType = .Shower
//        let nav = UINavigationController(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
//    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: 倒计时相关
extension MainViewController{
    
    @objc  func becomeActive(){
        MineGCDTimer.start {[weak self] _ in
            guard let `self` = self else{return}
            self.vcTimePass = (self.vcTimePass.diapre + 1,
                          self.vcTimePass.feed + 1,
                          self.vcTimePass.sleep + 1,
                          self.vcTimePass.pumpMilk + 1)
            self.timerPass()
        }
    }
    
    @objc  func becomeDeath(){
        MineGCDTimer.stop()
    }
    
    private func timerTitleInit(_ type:EventType,_ pastDate:Date) {
        let str = TimeFomatChange.getDateTimeFormat(TimeFomatChange.timeInterval(pastDate))
        switch type {
        case .diaper:
            lblDiaperTime.text = str
            initialTimer.diapre = str
            vcTimePass.diapre = 0
        case .feed:
            lblFeedTime.text = str
            initialTimer.feed = str
            vcTimePass.feed = 0
        case .pumpMilk:
            lblPumpMilkTime.text = str
            initialTimer.pumpMilk = str
            vcTimePass.pumpMilk = 0
        case .sleep:
            lblSleepTime.text = str
            initialTimer.sleep = str
            vcTimePass.sleep = 0
        }
    }
    
    private func timerPass() {
        if vcTimePass.diapre > 0 {
            lblDiaperTime.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.diapre) + vcTimePass.diapre)
        }
        if vcTimePass.feed > 0 {
            lblFeedTime.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.feed) + vcTimePass.feed)
        }
        if vcTimePass.pumpMilk > 0 {
            lblPumpMilkTime.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.pumpMilk) + vcTimePass.pumpMilk)
        }
        if vcTimePass.sleep > 0 {
            lblSleepTime.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.sleep) + vcTimePass.sleep)
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
            self.fetchOperateTotal()
        })
    }
    
    private func fetchOperateTotal() {
        self.dataViewModel.fetchOperateTotal {[weak self] (i) in
            guard let `self` = self else{return}
            self.btnRecord.setTitle("今日共产生\(i)条记录", for: .normal)
            self.fetchAllData()
        }
    }
    
    private func fetchAllData() {
        fetchFeedData()
        fetchDiaperData()
        fetchSleepData()
        fetchPumpMilkData()
    }
    
    private func fetchFeedData() {
        dataViewModel.fetchFeedModel {[weak self] (t, l, r) in
            guard let `self` = self else{return}
            self.lblFeedDes.text = "今日共喂奶\(t)次(左\(l)次,右\(r)次)"
            if let firObj = self.dataViewModel.arrFeed.first {
                self.timerTitleInit(.feed, firObj.eventTime?.value ?? Date())
            }else{
                self.timerTitleInit(.feed, Date())
            }
        }
    }
    
    private func fetchDiaperData() {
        dataViewModel.fetchDiaperModel {[weak self] (t, bAntN, b, n, g) in
            guard let `self` = self else{return}
            self.lblDiaperDes.text = "今日共换尿布\(t)次(便尿\(bAntN)次,便\(b)次,尿\(n)次)"
            if let firObj = self.dataViewModel.arrDiaper.first {
                self.timerTitleInit(.diaper, firObj.eventTime?.value ?? Date())
            }else{
                self.timerTitleInit(.diaper, Date())
            }
        }
    }
    
    private func fetchSleepData() {
        dataViewModel.fetchSleepModel {[weak self] (t, s) in
            guard let `self` = self else{return}
            if let total = t {
                self.lblSleepDes.text = "已睡\(total / 60)小时"
            }
            if let sleeping = s {
                self.lblSleepDes.text =  "\(sleeping)入睡,还未醒"
            }
            if let firObj = self.dataViewModel.arrSleep.first {
                self.timerTitleInit(.sleep, firObj.sleepStartTime?.value ?? Date())
            }else{
                self.timerTitleInit(.sleep, Date())
            }
        }
    }
    
    private func fetchPumpMilkData() {
        dataViewModel.fetchPumpMilk {[weak self] (t) in
            guard let `self` = self else{return}
            self.lblPumpMilkDes.text = "已泵奶\(Int(t))ml"
            if let firObj = self.dataViewModel.arrPump.first {
                self.timerTitleInit(.pumpMilk, firObj.eventTime?.value ?? Date())
                self.vcTimePass.pumpMilk = 0
            }else{
                self.timerTitleInit(.pumpMilk, Date())
            }
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
