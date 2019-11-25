//
//  SleepAppendViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/5.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class SleepAppendViewController: UIViewController {
    public var finishBlock : (()->Void)?
    public var currentModel : SleepEventModel?
    
    private var pickStartDate : Date = Date()
    private var pickEndDate : Date?
    private var wakeStatus : Double = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vBG.layer.cornerRadius = 100
        vBG.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        vBG.layer.masksToBounds = true
        vBG.layer.insertSublayer(
         GradientBGColor.setGradientBackgroundLayer(
             .sleep,
             width:UIScreen.main.bounds.width,
             height:vBG.frame.height),at: 0)
        btnE.layer.borderColor = UIColor.white.cgColor
        btnE.layer.cornerRadius = 5
        btnE.layer.borderWidth = 2
        btnZR.layer.borderColor = UIColor.white.cgColor
        btnZR.layer.cornerRadius = 5
        btnZR.layer.borderWidth = 0
        btnJX.layer.borderColor = UIColor.white.cgColor
        btnJX.layer.cornerRadius = 5
        btnJX.layer.borderWidth = 0
        btnXX.layer.borderColor = UIColor.white.cgColor
        btnXX.layer.cornerRadius = 5
        btnXX.layer.borderWidth = 0
        
        if let model = currentModel,
            let eventT = model.eventTime?.value{
            if TimeFomatChange.timeOneMinute(eventT) {
                btnStartDate.setTitle(TimeFomatChange.getDateString(eventT, "MM月dd日 HH:mm"), for: .normal)
                wakeHidden(true)
            }else{
                btnStartDate.setTitle(TimeFomatChange.getDateString(eventT, "MM月dd日 HH:mm"), for: .normal)
                btnEndDate.setTitle(TimeFomatChange.getDateString(Date(), "MM月dd日 HH:mm"), for: .normal)
                currentModel?.sleepEndTime = LCDate(Date())
                wakeHidden(false)
            }
        }else{
            btnStartDate.setTitle(TimeFomatChange.getDateString(Date(), "MM月dd日 HH:mm"), for: .normal)
            wakeHidden(true)
        }
    }
    
    deinit {
        currentModel?.sleepEndTime = nil
    }
    
    private func wakeHidden(_ hide:Bool) {
        btnE.isHidden = hide
        btnZR.isHidden = hide
        btnJX.isHidden = hide
        btnXX.isHidden = hide
        lblWakeStatus.isHidden = hide
        btnEnDateClean.isHidden = hide
    }

    @IBOutlet weak var vBG: UIView!
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var btnE: UIButton!
    @IBOutlet weak var btnZR: UIButton!
    @IBOutlet weak var btnJX: UIButton!
    @IBOutlet weak var btnXX: UIButton!
    @IBOutlet weak var btnEnDateClean: UIButton!
    @IBOutlet weak var lblWakeStatus: UILabel!
    
    @IBAction func didPressStart(_ sender: Any) {
        _ = DatePickView {[weak self] (vDate) in
            guard let `self` = self else{return}
            if let _ = self.currentModel {
                self.currentModel?.eventTime = LCDate(vDate.date)
            }else{
                self.pickStartDate = vDate.date
            }
            if TimeFomatChange.timeOneMinute(vDate.date) {
                self.btnStartDate.setTitle(TimeFomatChange.getDateString(vDate.date, "MM月dd日 HH:mm"), for: .normal)
                self.btnEndDate.setTitle("还没醒", for: .normal)
                self.wakeHidden(true)
            }else{
                self.btnStartDate.setTitle(TimeFomatChange.getDateString(vDate.date, "MM月dd日 HH:mm"), for: .normal)
                self.btnEndDate.setTitle(TimeFomatChange.getDateString(Date(), "MM月dd日 HH:mm"), for: .normal)
                if let _ = self.currentModel {
                    self.currentModel?.sleepEndTime = LCDate(Date())
                }else{
                    self.pickEndDate = Date()
                }
                self.wakeHidden(false)
            }
        }
    }
    
    @IBAction func didPressEnd(_ sender: Any) {
        _ = DatePickView {[weak self] (vDate) in
            guard let `self` = self else{return}
            var startDate : Date
            if let _ = self.currentModel {
                self.currentModel?.sleepEndTime = LCDate(vDate.date)
                startDate = (self.currentModel?.eventTime?.value)!
            }else{
                self.pickEndDate = vDate.date
                startDate = self.pickStartDate
            }
            if TimeFomatChange.timeInterval(startDate, currentDate: vDate.date) > 60 {
                self.btnEndDate.setTitle(TimeFomatChange.getDateString(vDate.date, "MM月dd日 HH:mm"), for: .normal)
                self.wakeHidden(false)
            }else{
                self.btnEndDate.setTitle("还没醒", for: .normal)
                self.wakeHidden(true)
                if let _ = self.currentModel {
                    self.currentModel?.sleepEndTime = nil
                }else{
                    self.pickEndDate = nil
                }
            }
        }
    }
    
    @IBAction func didPressWakeStatus(_ sender: Any) {
        let btn = sender as! UIButton
        wakeStatus = Double(btn.tag)
        btnE.layer.borderWidth = 0
        btnZR.layer.borderWidth = 0
        btnJX.layer.borderWidth = 0
        btnXX.layer.borderWidth = 0
        btn.layer.borderWidth = 2
    }
    
    @IBAction func DidPressEndDateClean(_ sender: Any) {
        if let _ = currentModel {
            currentModel?.sleepEndTime = nil
        }else{
            pickEndDate = nil
        }
        self.btnEndDate.setTitle("还没醒", for: .normal)
        self.wakeHidden(true)
    }
    
    @IBAction func didPressCancle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressSubmit(_ sender: Any) {
        if let _ = self.currentModel {
            self.currentModel?.wakeUpStatus = LCNumber(self.wakeStatus)
            DataBaseViewModel.updateModel((self.currentModel)!) {
                if let block = self.finishBlock {
                    block()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }else{
            let model = SleepEventModel()
            model.eventTime = LCDate(pickStartDate)
            if let pickEndDate = pickEndDate {
                model.sleepEndTime = LCDate(pickEndDate)
            }
            model.wakeUpStatus = LCNumber(self.wakeStatus)
            DataBaseViewModel.addModel(model) {[weak self] (model) in
                guard let `self` = self else{return}
                if let block = self.finishBlock {
                    block()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

}
