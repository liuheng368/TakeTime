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
//        vcInit()
    }
    
//    fileprivate func vcInit() {
//        MainBmobViewModel.fetchEnent(.Milk) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Milk, Date())
//            }else{
//                self.timerTitleInit(.Milk, arrModel.first?.eventDate ?? Date())
//            }
//        }
//        MainBmobViewModel.fetchEnent(.Water) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Water, Date())
//            }else{
//                self.timerTitleInit(.Water, arrModel.first?.eventDate ?? Date())
//            }
//        }
//        MainBmobViewModel.fetchEnent(.Diaper) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Diaper, Date())
//            }else{
//                self.timerTitleInit(.Diaper, arrModel.first?.eventDate ?? Date())
//            }
//        }
//        MainBmobViewModel.fetchEnent(.Shower) {[weak self] (arrModel) in
//            guard let `self` = self else{return}
//            if arrModel.count <= 0 {
//                self.timerTitleInit(.Shower, Date())
//            }else{
//                self.timerTitleInit(.Shower, arrModel.first?.eventDate ?? Date())
//            }
//        }
//    }
    
//    private func timerTitleInit(_ type:EventType,_ pastDate:Date) {
//        let str = TimeFomatChange.getDateTimeFormat(
//            TimeFomatChange.timeInterval(pastDate))
//        switch type {
//        case .Diaper:
//            lblDiapre.text = str
//        case .Milk:
//            lblMilk.text = str
//        case .Water:
//            lblWater.text = str
//        case .Shower:
//            lblShower.text = str
//        }
//    }
    
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
//        MainBmobViewModel.add(Date(), .Diaper, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.timerTitleInit(.Diaper, model.eventDate)
//        })
    }
    
    @IBAction func didPressMilk(_ sender: Any) {
//        MainBmobViewModel.add(Date(), .Milk, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.timerTitleInit(.Milk, model.eventDate)
//        })
    }
    
    @IBAction func didPressShower(_ sender: Any) {
//        MainBmobViewModel.add(Date(), .Shower, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.timerTitleInit(.Shower, model.eventDate)
//        })
    }
    
    @IBAction func didPressWater(_ sender: Any) {
//        MainBmobViewModel.add(Date(), .Water, success: {[weak self] (model) in
//            guard let `self` = self else{return}
//            self.timerTitleInit(.Water, model.eventDate)
//        })
    }
    
    @IBAction func didPressOpenApp(_ sender: Any) {
        extensionContext?.open(URL(string: "TodayWidget://")!, completionHandler: { _ in })
    }
}
