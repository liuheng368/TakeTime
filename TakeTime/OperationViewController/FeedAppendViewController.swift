//
//  FeedAppendViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/3.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

class FeedAppendViewController: UIViewController {

    public var finishBlock : ((FeedEventModel)->Void)?
    
    
    @IBOutlet weak var ivBg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivBg.layer.cornerRadius = 100
        ivBg.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        ivBg.layer.insertSublayer(GradientBGColor.setGradientBackgroundLayer(.sleep,width:UIScreen.main.bounds.width , height:ivBg.frame.height), at: 0)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
