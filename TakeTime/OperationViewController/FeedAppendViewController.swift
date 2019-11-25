//
//  FeedAppendViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/3.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class FeedAppendViewController: UIViewController {

    public var finishBlock : (()->Void)?
    
    @IBOutlet weak var vBG: UIView!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnLeft: titLeftButton!
    @IBOutlet weak var btnRight: UIButton!
    
    private var pickDate : Date = Date()
    private var orLeft : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vBG.layer.cornerRadius = 100
        vBG.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        vBG.layer.masksToBounds = true
        vBG.layer.insertSublayer(
         GradientBGColor.setGradientBackgroundLayer(
             .feed,
             width:UIScreen.main.bounds.width,
             height:vBG.frame.height),at: 0)
        
        btnLeft.layer.borderColor = UIColor.white.cgColor
        btnLeft.layer.cornerRadius = 30
        btnLeft.layer.borderWidth = 2
        btnRight.layer.borderColor = UIColor.white.cgColor
        btnRight.layer.cornerRadius = 30
        btnRight.layer.borderWidth = 0
        btnDate.setTitle(TimeFomatChange.getDateString(Date(), "MM月dd日 HH:mm"), for: .normal)
    }

    @IBAction func didPressDatePick(_ sender: Any) {
        _ = DatePickView {[weak self] (vDate) in
            guard let `self` = self else{return}
            self.pickDate = vDate.date
            self.btnDate.setTitle(TimeFomatChange.getDateString(vDate.date, "MM月dd日 HH:mm"), for: .normal)
        }
    }
    
    @IBAction func didPressLeft(_ sender: Any) {
        orLeft = true
        btnLeft.layer.borderWidth = 2
        btnRight.layer.borderWidth = 0
    }
    
    @IBAction func didPressRight(_ sender: Any) {
        orLeft = false
        btnLeft.layer.borderWidth = 0
        btnRight.layer.borderWidth = 2
    }
    
    @IBAction func didPressCancle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressSure(_ sender: Any) {
        let model = FeedEventModel()
        model.eventTime = LCDate(pickDate)
        model.feedOri = LCNumber(orLeft ? 1 : 2)
        DataBaseViewModel.addModel(model) {[weak self] (_) in
            guard let `self` = self else{return}
            if let block = finishBlock {
                block()
                LocationNotification.addNotification()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
