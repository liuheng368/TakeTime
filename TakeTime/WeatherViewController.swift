//
//  WeatherViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/10/24.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        showViewWithFrame()
    }
    
    func showViewWithFrame(){
        let weatherView = HeFengPluginView(frame: CGRect(x: 50, y: 200, width: 50, height: 50), viewType: .leftLarge, userKey: "d4d211b3144548898f1ffb833c9222eb", location: "")
        let leftModel = HeFengConfigModel()
        leftModel.iconSize = 40
        leftModel.type = .weatherStateIcon
        let rightModel = HeFengConfigModel()
        rightModel.textFont = UIFont.systemFont(ofSize: 20)
        rightModel.type = .temp
        let bottonModel = HeFengConfigModel()
        bottonModel.iconSize = 12
        bottonModel.textFont = UIFont.systemFont(ofSize: 20)
        bottonModel.type = .weatherState
        weatherView?.configArray = [[leftModel], [rightModel], [bottonModel]]
        weatherView?.contentViewAlignmen = .center
        weatherView?.padding = UIEdgeInsets.zero
        weatherView?.themType = .light
        weatherView?.isShowBorder = false
        weatherView?.navigationBarBackgroundColor = UIColor.red
        self.view.addSubview(weatherView!)
    }

}
