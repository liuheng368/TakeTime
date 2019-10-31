//
//  GradientBGColor.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/10/31.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let feedStartBGcolor = UIColor(red:1, green:0.22, blue:0.67, alpha:1).cgColor
let feedMediumBGcolor = UIColor(red:1, green:0.26, blue:0.73, alpha:1).cgColor
let feedEndBGColor = UIColor(red:1, green:0.22, blue:0.76, alpha:1).cgColor

let diaperStartBGcolor = UIColor(red:1, green:0.58, blue:0.25, alpha:1).cgColor
let diaperMediumBGcolor = UIColor(red:1, green:0.66, blue:0.27, alpha:1).cgColor
let diaperEndBGColor = UIColor(red:1, green:0.7, blue:0.22, alpha:1).cgColor

let sleepStartBGcolor = UIColor(red:0.21, green:0.62, blue:1, alpha:1).cgColor
let sleepMediumBGcolor = UIColor(red:0.26, green:0.72, blue:1, alpha:1).cgColor
let sleepEndBGColor = UIColor(red:0.22, green:0.82, blue:1, alpha:1).cgColor

let pumpMilkStartBGcolor = UIColor(red:0.17, green:0.82, blue:0.78, alpha:1).cgColor
let pumpMilkMediumBGcolor = UIColor(red:0.23, green:0.87, blue:0.76, alpha:1).cgColor
let pumpMilkEndBGColor = UIColor(red:0.21, green:0.91, blue:0.71, alpha:1).cgColor


class GradientBGColor {
    class func setGradientBackgroundColors(_ type:EventType) -> UIImage {
        let kScreenW = UIScreen.main.bounds.width - 30
        let kHeight : CGFloat = 88
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x:0,y:0)
        gradient.endPoint   = CGPoint(x:1,y:0)
        gradient.frame = CGRect(x:0,y:0,width:kScreenW,height:kHeight)
        gradient.locations = [0,0.5,1]
        switch type {
        case .feed:
            gradient.colors = [feedStartBGcolor, feedMediumBGcolor, feedEndBGColor]
        case .diaper:
            gradient.colors = [diaperStartBGcolor, diaperMediumBGcolor, diaperEndBGColor]
        case .sleep:
            gradient.colors = [sleepStartBGcolor, sleepMediumBGcolor, sleepEndBGColor]
        case .pumpMilk:
            gradient.colors = [pumpMilkStartBGcolor, pumpMilkMediumBGcolor, pumpMilkEndBGColor]
        }
        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}
