//
//  GradientBGColor.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/10/31.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let feedStartBGcolor = UIColor(red:1, green:0.22, blue:0.67, alpha:1)
let feedMediumBGcolor = UIColor(red:1, green:0.26, blue:0.73, alpha:1)
let feedEndBGColor = UIColor(red:1, green:0.26, blue:0.78, alpha:1)

let diaperStartBGcolor = UIColor(red:1, green:0.58, blue:0.25, alpha:1)
let diaperMediumBGcolor = UIColor(red:1, green:0.66, blue:0.27, alpha:1)
let diaperEndBGColor = UIColor(red:1, green:0.71, blue:0.26, alpha:1)

let sleepStartBGcolor = UIColor(red:0.21, green:0.62, blue:1, alpha:1)
let sleepMediumBGcolor = UIColor(red:0.26, green:0.72, blue:1, alpha:1)
let sleepEndBGColor = UIColor(red:0.22, green:0.82, blue:1, alpha:1)

let pumpMilkStartBGcolor = UIColor(red:0.17, green:0.82, blue:0.78, alpha:1)
let pumpMilkMediumBGcolor = UIColor(red:0.23, green:0.87, blue:0.76, alpha:1)
let pumpMilkEndBGColor = UIColor(red:0.21, green:0.91, blue:0.71, alpha:1)


class GradientBGColor {
    class func setGradientBackgroundColors(_ type:EventType, width:CGFloat = UIScreen.main.bounds.width - 30, height:CGFloat = 88) -> UIImage {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x:0.5,y:1)
        gradient.endPoint   = CGPoint(x:0.5,y:0)
        gradient.frame = CGRect(x:0,y:0,width:width,height:height)
        gradient.locations = [0,0.5,1]
        switch type {
        case .feed:
            gradient.colors = [feedStartBGcolor.cgColor, feedMediumBGcolor.cgColor, feedEndBGColor.cgColor]
        case .diaper:
            gradient.colors = [diaperStartBGcolor.cgColor, diaperMediumBGcolor.cgColor, diaperEndBGColor.cgColor]
        case .sleep:
            gradient.colors = [sleepStartBGcolor.cgColor, sleepMediumBGcolor.cgColor, sleepEndBGColor.cgColor]
        case .pumpMilk:
            gradient.colors = [pumpMilkStartBGcolor.cgColor, pumpMilkMediumBGcolor.cgColor, pumpMilkEndBGColor.cgColor]
        }
        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
    class func setGradientBackgroundLayer(_ type:EventType, width:CGFloat = UIScreen.main.bounds.width - 30, height:CGFloat = 88) -> CALayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x:0.5,y:0)
        gradient.endPoint   = CGPoint(x:0.5,y:1)
        gradient.frame = CGRect(x:0,y:0,width:width,height:height)
        gradient.locations = [0,0.5,1]
        switch type {
        case .feed:
            gradient.colors = [feedStartBGcolor.cgColor, feedMediumBGcolor.cgColor, feedEndBGColor.cgColor]
        case .diaper:
            gradient.colors = [diaperStartBGcolor.cgColor, diaperMediumBGcolor.cgColor, diaperEndBGColor.cgColor]
        case .sleep:
            gradient.colors = [sleepStartBGcolor.cgColor, sleepMediumBGcolor.cgColor, sleepEndBGColor.cgColor]
        case .pumpMilk:
            gradient.colors = [pumpMilkStartBGcolor.cgColor, pumpMilkMediumBGcolor.cgColor, pumpMilkEndBGColor.cgColor]
        }
        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        return gradient
    }
}
