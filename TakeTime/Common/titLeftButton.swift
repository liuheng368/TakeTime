//
//  titLeftButton.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/4.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class titLeftButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        var titleF = titleLabel?.frame
        var imageF = imageView?.frame
        if let _ = titleF{
            titleF?.origin.x = 0
            titleLabel?.frame = titleF!
            imageF?.origin.x = titleF!.maxX
        }
        if let imageF = imageF {
            imageView?.frame = imageF
        }
    }

}

extension UIView {
    
    public enum ShakeDirection: Int {
        case horizontal
        case vertical
    }
    
    /// 扩展UIView增加抖动方法
    ///
    /// - Parameters:
    ///   - direction:  抖动方向    默认水平方向
    ///   - times:      抖动次数    默认5次
    ///   - interval:   每次抖动时间 默认0.1秒
    ///   - offset:     抖动的偏移量 默认2个点
    ///   - completion: 抖动结束回调
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 5, interval: TimeInterval = 0.1, offset: CGFloat = 2, completion: (() -> Void)? = nil) {
        
        //移动视图动画（一次）
        UIView.animate(withDuration: interval, animations: {
            switch direction {
                case .horizontal:
                    self.layer.setAffineTransform(CGAffineTransform(translationX: offset, y: 0))
                case .vertical:
                    self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: offset))
            }
            
        }) { (complete) in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) in
                    completion?()
                })
            }
            //如果当前不是最后一次，则继续动画，偏移位置相反
            else {
                self.shake(direction: direction, times: times - 1, interval: interval, offset: -offset, completion: completion)
            }
        }
    }
}
