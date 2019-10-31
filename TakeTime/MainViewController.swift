//
//  MainViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/21.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

//extension MainViewController: UIPickerViewDataSource,UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 3
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch component {
//        case 0:
//            return arrType.count
//        case 1:
//            return arrHour.count
//        case 2:
//            return arrMinute.count
//        default:
//            return 0
//        }
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        for view in pickerView.subviews {
//            if view.frame.size.height < 1 {
//                view.backgroundColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)
//            }
//        }
//        let lab = UILabel()
//        lab.textAlignment = NSTextAlignment.center
//        lab.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
//        lab.font = UIFont.systemFont(ofSize: 20)
//        if component == 0 {
//            lab.text = arrType[row]
//        }else if component == 1 {
//            lab.text = arrHour[row]
//        }else{
//            lab.text = arrMinute[row]
//        }
//        return lab
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch component {
//        case 0:
//            pickSelectData.type = row
//        case 1:
//            pickSelectData.hour = row
//        case 2:
//            pickSelectData.minute = row
//        default:break
//        }
//    }
//}

extension MainViewController {
//    fileprivate func vcInit() {
//        MainBmobViewModel.fetchEnent(.Milk) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Milk, Date())
//            }else{
//                self.timerTitleInit(.Milk, arrModel.first?.eventDate ?? Date())
//                self.vcTimePass.milk = 0
//            }
//        }
//        MainBmobViewModel.fetchEnent(.Water) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Water, Date())
//            }else{
//                self.timerTitleInit(.Water, arrModel.first?.eventDate ?? Date())
//                self.vcTimePass.water = 0
//            }
//        }
//        MainBmobViewModel.fetchEnent(.Diaper) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Diaper, Date())
//            }else{
//                self.timerTitleInit(.Diaper, arrModel.first?.eventDate ?? Date())
//                self.vcTimePass.diapre = 0
//            }
//        }
//        MainBmobViewModel.fetchEnent(.Shower) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Shower, Date())
//            }else{
//                self.timerTitleInit(.Shower, arrModel.first?.eventDate ?? Date())
//                self.vcTimePass.shower = 0
//            }
//        }
//        MineGCDTimer.start {[weak self] _ in
//            guard let `self` = self else{return}
//            self.vcTimePass = (self.vcTimePass.water + 1,
//                          self.vcTimePass.milk + 1,
//                          self.vcTimePass.diapre + 1,
//                          self.vcTimePass.shower + 1)
//            self.timerPass()
//        }
//    }
    
//    private func timerTitleInit(_ type:EventType,_ pastDate:Date) {
//        let str = TimeFomatChange.getDateTimeFormat(
//            TimeFomatChange.timeInterval(pastDate))
//        switch type {
//        case .Diaper:
//            lblDiaper.text = str
//            initialTimer.diapre = str
//        case .Milk:
//            lblMilk.text = str
//            initialTimer.milk = str
//        case .Water:
//            lblWater.text = str
//            initialTimer.water = str
//        case .Shower:
//            lblShwoer.text = str
//            initialTimer.shower = str
//        }
//    }
    
//    private func timerPass() {
//        if vcTimePass.diapre > 0 {
//            lblDiaper.text = TimeFomatChange.getDateTimeFormat(
//                TimeFomatChange.stringToTimeStamp(initialTimer.diapre) + vcTimePass.diapre)
//        }
//        if vcTimePass.milk > 0 {
//            lblMilk.text = TimeFomatChange.getDateTimeFormat(
//                TimeFomatChange.stringToTimeStamp(initialTimer.milk) + vcTimePass.milk)
//        }
//        if vcTimePass.water > 0 {
//            lblWater.text = TimeFomatChange.getDateTimeFormat(
//                TimeFomatChange.stringToTimeStamp(initialTimer.water) + vcTimePass.water)
//        }
//        if vcTimePass.shower > 0 {
//            lblShwoer.text = TimeFomatChange.getDateTimeFormat(
//                TimeFomatChange.stringToTimeStamp(initialTimer.shower) + vcTimePass.shower)
//        }
//    }
}

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
    @IBAction func didPressFeed(_ sender: Any) {
    }
    
    //diaper
    @IBOutlet weak var vDiaper: UIView!
    @IBOutlet weak var bgDiaper: UIImageView!
    @IBOutlet weak var lblDiaperTime: UILabel!
    @IBOutlet weak var lblDiaperDes: UILabel!
    @IBAction func didPressDiaper(_ sender: Any) {
    }
    
    //sleep
    @IBOutlet weak var vSleep: UIView!
    @IBOutlet weak var bgSleep: UIImageView!
    @IBOutlet weak var lblSleepTime: UILabel!
    @IBOutlet weak var lblSleepDes: UILabel!
    @IBAction func didPressSleep(_ sender: Any) {
    }
    
    //pumpMilk
    @IBOutlet weak var vPumpMilk: UIView!
    @IBOutlet weak var bgPumpMilk: UIImageView!
    @IBOutlet weak var lblPumpMilkDes: UILabel!
    @IBOutlet weak var lblPumpMilkTime: UILabel!
    @IBAction func didPressPumpMilk(_ sender: Any) {
    }
    
    @IBAction func didPressRecord(_ sender: Any) {
    }
    
    @IBAction func didPressClock(_ sender: Any) {
    }
    
    private var vcTimePass : (water:Int,milk:Int,diapre:Int,shower:Int) = (Int.min,Int.min,Int.min,Int.min)
    private var initialTimer : (water:String,milk:String,diapre:String,shower:String) = ("","","","")
    private let arrType = ["喝奶","喝水","换尿布","洗澡"]
    private let arrHour = { () -> [String] in
        var arr : [String] = []
        for i in 0...23{
            arr.append("\(i)")
        }
        return arr
    }()
    private let arrMinute = { () -> [String] in
        var arr : [String] = []
        for i in 0...59{
            arr.append("\(i)")
        }
        return arr
    }()
    private var pickSelectData : (type:Int,hour:Int,minute:Int) = (0,0,0)
    lazy var calendar:Calendar = {
        return Calendar.current
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        vcInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册进入前台的通知
        NotificationCenter.default.addObserver(self, selector:#selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        //注册进入后台的通知
        NotificationCenter.default.addObserver(self, selector:#selector(becomeDeath), name: UIApplication.willResignActiveNotification, object: nil)
        showViewWithFrame()
        pageUIInit()
    }
    
    @objc  func becomeActive(noti:Notification){
//        vcInit()
    }
    
    @objc  func becomeDeath(noti:Notification){
        MineGCDTimer.stop()
    }
    
    //MARK: Point Event
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
//    @IBAction func didPressPickView(_ sender: Any) {
//        vPick.isHidden = false
//        let comp:DateComponents = (self.calendar as NSCalendar).components([.hour, .minute], from: Date())
//        pickView.selectRow(comp.hour!, inComponent: 1, animated: false)
//        pickView.selectRow(comp.minute!, inComponent: 2, animated: false)
//        pickSelectData.hour = comp.hour!
//        pickSelectData.minute = comp.minute!
//    }
//
//    @IBAction func didPressPickCancle(_ sender: Any) {
//        vPick.isHidden = true
//    }
    
    @IBAction func didPressPickSure(_ sender: Any) {
//        vPick.isHidden = true
//        let comp:DateComponents = (self.calendar as NSCalendar).components([.year, .month, .day], from: Date())
//        let strTime = "\(comp.year!)-\(comp.month!)-\(comp.day!)-\(pickSelectData.hour)-\(pickSelectData.minute)"
//        let dateFor = DateFormatter()
//        dateFor.dateFormat = "yyyy-MM-dd-HH-mm"
//        let date = dateFor.date(from: strTime)!
//
//        switch pickSelectData.type {
//        case 0:
////            MainBmobViewModel.add(date, .Milk, success: {[weak self] (model) in
////                guard let `self` = self else{return}
////                self.vcTimePass.milk = 0
////                self.vcInit()
////            })
//        case 1:
////            MainBmobViewModel.add(date, .Water, success: {[weak self] (model) in
////                guard let `self` = self else{return}
////                self.vcTimePass.water = 0
////                self.vcInit()
////            })
//        case 2:
////            MainBmobViewModel.add(date, .Diaper, success: {[weak self] (model) in
////                guard let `self` = self else{return}
////                self.vcTimePass.milk = 0
////                self.vcInit()
////            })
//        case 3:
////            MainBmobViewModel.add(date, .Shower, success: {[weak self] (model) in
////                guard let `self` = self else{return}
////                self.vcTimePass.milk = 0
////                self.vcInit()
////            })
//        default:break
//        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

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
    
    func showViewWithFrame() {
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
        vWeather.addSubview(weatherView!)
    }
}
