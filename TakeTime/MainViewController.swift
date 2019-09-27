//
//  MainViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/21.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

extension MainViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return arrType.count
        case 1:
            return arrHour.count
        case 2:
            return arrMinute.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for view in pickerView.subviews {
            if view.frame.size.height < 1 {
                view.backgroundColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)
            }
        }
        let lab = UILabel()
        lab.textAlignment = NSTextAlignment.center
        lab.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        lab.font = UIFont.systemFont(ofSize: 20)
        if component == 0 {
            lab.text = arrType[row]
        }else if component == 1 {
            lab.text = arrHour[row]
        }else{
            lab.text = arrMinute[row]
        }
        return lab
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            pickSelectData.type = row
        case 1:
            pickSelectData.hour = row
        case 2:
            pickSelectData.minute = row
        default:break
        }
    }
}

extension MainViewController {
    fileprivate func vcInit() {
        if let dia = MainViewModel.fetchEnent(.Diaper).last{
            timerTitleInit(.Diaper, dia.eventDate! as Date)
            vcTimePass.diapre = 0
        }else{
            timerTitleInit(.Diaper, Date())
        }
        if let mi = MainViewModel.fetchEnent(.Milk).last{
            timerTitleInit(.Milk, mi.eventDate! as Date)
            vcTimePass.milk = 0
        }else{
            timerTitleInit(.Milk, Date())
        }
        if let sh = MainViewModel.fetchEnent(.Shower).last{
            timerTitleInit(.Shower, sh.eventDate! as Date)
            vcTimePass.shower = 0
        }else{
            timerTitleInit(.Shower, Date())
        }
        if let wa = MainViewModel.fetchEnent(.Water).last{
            timerTitleInit(.Water, wa.eventDate! as Date)
            vcTimePass.water = 0
        }else{
            timerTitleInit(.Water, Date())
        }
        MineGCDTimer.start {[weak self] _ in
            guard let `self` = self else{return}
            self.vcTimePass = (self.vcTimePass.water + 1,
                          self.vcTimePass.milk + 1,
                          self.vcTimePass.diapre + 1,
                          self.vcTimePass.shower + 1)
            self.timerPass()
        }
    }
    
    private func timerTitleInit(_ type:EventType,_ pastDate:Date) {
        let str = TimeFomatChange.getDateTimeFormat(
            TimeFomatChange.timeInterval(pastDate))
        switch type {
        case .Diaper:
            lblDiaper.text = str
            initialTimer.diapre = str
        case .Milk:
            lblMilk.text = str
            initialTimer.milk = str
        case .Water:
            lblWater.text = str
            initialTimer.water = str
        case .Shower:
            lblShwoer.text = str
            initialTimer.shower = str
        }
    }
    
    private func timerPass() {
        if vcTimePass.diapre > 0 {
            lblDiaper.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.diapre) + vcTimePass.diapre)
        }
        if vcTimePass.milk > 0 {
            lblMilk.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.milk) + vcTimePass.milk)
        }
        if vcTimePass.water > 0 {
            lblWater.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.water) + vcTimePass.water)
        }
        if vcTimePass.shower > 0 {
            lblShwoer.text = TimeFomatChange.getDateTimeFormat(
                TimeFomatChange.stringToTimeStamp(initialTimer.shower) + vcTimePass.shower)
        }
    }
}

class MainViewController: UIViewController {

    @IBOutlet weak var lblShwoer: UILabel!
    @IBOutlet weak var lblWater: UILabel!
    @IBOutlet weak var lblDiaper: UILabel!
    @IBOutlet weak var lblMilk: UILabel!
    
    @IBOutlet weak var btnWater: UIButton!
    @IBOutlet weak var btnMilk: UIButton!
    @IBOutlet weak var btnDiaper: UIButton!
    @IBOutlet weak var btnShower: UIButton!
    @IBOutlet weak var vPick: UIView!
    @IBOutlet weak var pickView: UIPickerView!
    
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
        vcInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册进入前台的通知
        NotificationCenter.default.addObserver(self, selector:#selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        //注册进入后台的通知
        NotificationCenter.default.addObserver(self, selector:#selector(becomeDeath), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc  func becomeActive(noti:Notification){
        vcInit()
    }
    
    @objc  func becomeDeath(noti:Notification){
        MineGCDTimer.stop()
    }
    
    //MARK: Point Event
    @IBAction func didPressWater(_ sender: Any) {
        MainViewModel.add(.Water, Date())
        vcTimePass.water = 0
        timerTitleInit(.Water, Date())
    }
    
    @IBAction func didPressMilk(_ sender: Any) {
        MainViewModel.add(.Milk, Date())
        vcTimePass.milk = 0
        timerTitleInit(.Milk, Date())
    }
    
    @IBAction func didPressDiaper(_ sender: Any) {
        MainViewModel.add(.Diaper, Date())
        vcTimePass.diapre = 0
        timerTitleInit(.Diaper, Date())
    }
    
    @IBAction func didPressShower(_ sender: Any) {
        MainViewModel.add(.Shower, Date())
        vcTimePass.shower = 0
        timerTitleInit(.Shower, Date())
    }
    
    //MARK: Look For List
    @IBAction func didPressMilkList(_ sender: Any) {
        let vc = EventTableViewController()
        vc.vcType = .Milk
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func didPressDiaperList(_ sender: Any) {
        let vc = EventTableViewController()
        vc.vcType = .Diaper
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func didPressWaterList(_ sender: Any) {
        let vc = EventTableViewController()
        vc.vcType = .Water
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func didPressShowerList(_ sender: Any) {
        let vc = EventTableViewController()
        vc.vcType = .Shower
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    @IBAction func didPressPickView(_ sender: Any) {
        vPick.isHidden = false
        let comp:DateComponents = (self.calendar as NSCalendar).components([.hour, .minute], from: Date())
        pickView.selectRow(comp.hour!, inComponent: 1, animated: false)
        pickView.selectRow(comp.minute!, inComponent: 2, animated: false)
        pickSelectData.hour = comp.hour!
        pickSelectData.minute = comp.minute!
    }
    
    @IBAction func didPressPickCancle(_ sender: Any) {
        vPick.isHidden = true
    }
    
    @IBAction func didPressPickSure(_ sender: Any) {
        vPick.isHidden = true
        let comp:DateComponents = (self.calendar as NSCalendar).components([.year, .month, .day], from: Date())
        let strTime = "\(comp.year!)-\(comp.month!)-\(comp.day!)-\(pickSelectData.hour)-\(pickSelectData.minute)"
        let dateFor = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd-HH-mm"
        let date = dateFor.date(from: strTime)!

        switch pickSelectData.type {
        case 0:
            MainViewModel.add(.Milk, date)
            vcTimePass.milk = 0
            timerTitleInit(.Milk, date)
        case 1:
            MainViewModel.add(.Water, date)
            vcTimePass.water = 0
            timerTitleInit(.Water, date)
        case 2:
            MainViewModel.add(.Diaper, date)
            vcTimePass.diapre = 0
            timerTitleInit(.Diaper, date)
        case 3:
            MainViewModel.add(.Shower, date)
            vcTimePass.shower = 0
            timerTitleInit(.Shower, date)
        default:break
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

