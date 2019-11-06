//
//  PumpMilkAppendViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/5.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class PumpMilkAppendViewController: UIViewController,UITextFieldDelegate {
    public var finishBlock : (()->Void)?
    public var arrPump : [PumpMilkEventModel] = []
    
    private var pickDate : Date = Date()
    private var left : Int = 0
    private var right : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vBG.layer.cornerRadius = 100
        vBG.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        vBG.layer.masksToBounds = true
        vBG.layer.insertSublayer(
         GradientBGColor.setGradientBackgroundLayer(
             .pumpMilk,
             width:UIScreen.main.bounds.width,
             height:vBG.frame.height),at: 0)
        tfLeft.attributedPlaceholder = NSAttributedString(string: "毫升", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        tfRight.attributedPlaceholder = NSAttributedString(string: "毫升", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        btnDatePick.setTitle(TimeFomatChange.getDateString(Date(), "MM月dd日 HH:mm"), for: .normal)
        lblTotal.text = "总库存: \(arrPump.reduce(0) { $0 + Int($1.totalAmout?.value ?? 0)})毫升"
    }

    @IBOutlet weak var vBG: UIView!
    @IBOutlet weak var tfRight: UITextField!
    @IBOutlet weak var tfLeft: UITextField!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnDatePick: UIButton!
    
    @IBAction func didPressCancle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressSure(_ sender: Any) {
        if left <= 0 && right <= 0 {
            tfRight.shake()
            tfLeft.shake()
            return
        }
        let model = PumpMilkEventModel()
        model.eventTime = LCDate(pickDate)
        model.leftAmout = LCNumber(Double(left))
        model.rightAmout = LCNumber(Double(right))
        model.totalAmout = LCNumber(Double(left + right))
        DataBaseViewModel.addModel(model) {[weak self] (_) in
            guard let `self` = self else{return}
            if let block = finishBlock {
                block()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didPressDatePick(_ sender: Any) {
        _ = DatePickView {[weak self] (date) in
            guard let `self` = self else{return}
            self.pickDate = date
            self.btnDatePick.setTitle(TimeFomatChange.getDateString(date, "MM月dd日 HH:mm"), for: .normal)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: "毫升", with: "")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfLeft {
            left = Int(textField.text!) ?? 0
        }else{
            right = Int(textField.text!) ?? 0
        }
        textField.text = (textField.text)! + (textField.text!.count > 0 ? "毫升" : "")
        let total = arrPump.reduce(0) { $0 + Int($1.totalAmout?.value ?? 0)}
        lblTotal.text = "总库存: \(total + left + right)毫升"
    }
}
