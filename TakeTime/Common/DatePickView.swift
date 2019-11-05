//
//  DatePickView.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/5.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class DatePickView: UIView {
    
    public init(_ blockAction_:@escaping ((Date)->Void)) {
        self.blockAction = blockAction_
        super.init(frame: CGRect.zero)
        initFromXib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initFromXib() {
        //mainview
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DatePickView", bundle: bundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView!)
        mainView?.translatesAutoresizingMaskIntoConstraints = false
        let dicIcon = ["mainView" : mainView!]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: dicIcon))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: dicIcon))
        //mask
        let window = UIApplication.shared.windows.first
        myMaskView = UIView(frame: window?.frame ?? CGRect.zero)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        myMaskView?.addGestureRecognizer(tap)
        //blur
        let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let effectview = UIVisualEffectView(effect: blur)
        effectview.frame = myMaskView!.frame
        effectview.alpha = 0.5
        self.insertSubview(effectview, at: 0)
        myMaskView?.addSubview(effectview)
        window?.addSubview(myMaskView!)
        //self
        window?.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let dicWinIcon = ["self" : self]
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[self]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: dicWinIcon))
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[self(\(250))]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: dicWinIcon))
    }
    
    private var mainView : UIView?
    private var myMaskView : UIView?
    private var blockAction : ((Date)->Void)
    @IBOutlet weak var vDatePick: UIDatePicker!
    
    @IBAction func didPressSure(_ sender: Any) {
        blockAction(vDatePick.date)
        hide()
    }
    
    @IBAction func didPreseCancle(_ sender: Any) {
        self.removeFromSuperview()
        myMaskView?.removeFromSuperview()
        myMaskView = nil
        mainView = nil
    }
    
    @objc func hide() {
        blockAction(vDatePick.date)
        self.removeFromSuperview()
        myMaskView?.removeFromSuperview()
        myMaskView = nil
        mainView = nil
    }
}
