//
//  TodayViewController.swift
//  TakeTimeToday
//
//  Created by 刘恒 on 2019/9/22.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var lblMilk: UILabel!
    @IBOutlet weak var lblDiapre: UILabel!
    @IBOutlet weak var lblWater: UILabel!
    @IBOutlet weak var lblShower: UILabel!
    @IBOutlet weak var btnPushApp: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vcInit()
    }
    
    fileprivate func vcInit() {
        if let dia = MainViewModel.fetchEnent(.Diaper).last{
            timerTitleInit(.Diaper, dia.eventDate! as Date)
        }else{
            timerTitleInit(.Diaper, Date())
        }
        if let mi = MainViewModel.fetchEnent(.Milk).last{
            timerTitleInit(.Milk, mi.eventDate! as Date)
        }else{
            timerTitleInit(.Milk, Date())
        }
        if let sh = MainViewModel.fetchEnent(.Shower).last{
            timerTitleInit(.Shower, sh.eventDate! as Date)
        }else{
            timerTitleInit(.Shower, Date())
        }
        if let wa = MainViewModel.fetchEnent(.Water).last{
            timerTitleInit(.Water, wa.eventDate! as Date)
        }else{
            timerTitleInit(.Water, Date())
        }
    }
    
    private func timerTitleInit(_ type:EventType,_ pastDate:Date) {
        let str = TimeFomatChange.getDateTimeFormat(
            TimeFomatChange.timeInterval(pastDate))
        switch type {
        case .Diaper:
            lblDiapre.text = str
        case .Milk:
            lblMilk.text = str
        case .Water:
            lblWater.text = str
        case .Shower:
            lblShower.text = str
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
        MainViewModel.add(.Diaper, Date())
        timerTitleInit(.Diaper, Date())
    }
    
    @IBAction func didPressMilk(_ sender: Any) {
        MainViewModel.add(.Milk, Date())
        timerTitleInit(.Milk, Date())
    }
    
    @IBAction func didPressShower(_ sender: Any) {
        MainViewModel.add(.Shower, Date())
        timerTitleInit(.Shower, Date())
    }
    
    @IBAction func didPressWater(_ sender: Any) {
        MainViewModel.add(.Water, Date())
        timerTitleInit(.Water, Date())
    }
    
    @IBAction func didPressOpenApp(_ sender: Any) {
        extensionContext?.open(URL(string: "TodayWidget://")!, completionHandler: { _ in })
    }
}
