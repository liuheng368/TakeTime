//
//  DiaperAppendViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/5.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class DiaperAppendViewController: UIViewController {

    public var finishBlock : (()->Void)?
    
    private var pickDate : Date = Date()
    private var pickStatus : Double = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vBG.layer.cornerRadius = 100
        vBG.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        vBG.layer.masksToBounds = true
        vBG.layer.insertSublayer(
         GradientBGColor.setGradientBackgroundLayer(
             .diaper,
             width:UIScreen.main.bounds.width,
             height:vBG.frame.height),at: 0)
        
        btnBianNiao.layer.borderColor = UIColor.white.cgColor
        btnBianNiao.layer.cornerRadius = 3
        btnBianNiao.layer.borderWidth = 2
        btnBian.layer.borderColor = UIColor.white.cgColor
        btnBian.layer.cornerRadius = 3
        btnBian.layer.borderWidth = 0
        btnNiao.layer.borderColor = UIColor.white.cgColor
        btnNiao.layer.cornerRadius = 3
        btnNiao.layer.borderWidth = 0
        btnGan.layer.borderColor = UIColor.white.cgColor
        btnGan.layer.cornerRadius = 3
        btnGan.layer.borderWidth = 0
        btnDatePick.setTitle(TimeFomatChange.getDateString(Date(), "MM月dd日 HH:mm"), for: .normal)
    }

    @IBOutlet weak var vBG: UIView!
    @IBOutlet weak var btnDatePick: UIButton!
    @IBOutlet weak var btnBianNiao: UIButton!
    @IBOutlet weak var btnBian: UIButton!
    @IBOutlet weak var btnNiao: UIButton!
    @IBOutlet weak var btnGan: UIButton!
    
    @IBAction func didPressStatusPick(_ sender: Any) {
        let btn = sender as! UIButton
        pickStatus = Double(btn.tag)
        btnBianNiao.layer.borderWidth = 0
        btnBian.layer.borderWidth = 0
        btnNiao.layer.borderWidth = 0
        btnGan.layer.borderWidth = 0
        btn.layer.borderWidth = 2
    }
    
    
    @IBAction func didPressDatePick(_ sender: Any) {
        _ = DatePickView {[weak self] (date) in
            guard let `self` = self else{return}
            self.pickDate = date
            self.btnDatePick.setTitle(TimeFomatChange.getDateString(date, "MM月dd日 HH:mm"), for: .normal)
        }
    }
    
    @IBAction func didPressCancle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressSure(_ sender: Any) {
        let model = DiaperEventModel()
        model.eventTime = LCDate(pickDate)
        model.diaperStatus = LCNumber(pickStatus)
        DataBaseViewModel.addModel(model) { (_) in
            if let block = finishBlock {
                block()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
