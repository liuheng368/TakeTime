//
//  timePicket.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/1.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class timePicket: NSObject {
/*
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
     
     //    @IBAction func didPressPickSure(_ sender: Any) {
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
     //    }
     */
}
