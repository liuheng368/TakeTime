//
//  LeanCloudLogin.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/10/28.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit
import LeanCloud

class LeanCloudLogin {
    
    class func signUp() {
        let user = LCUser()
        user.username = "liuheng368"
        user.password = "dashu365"
        user.setValue("15102204662", forKey: "mobilePhoneNumber")
        assert(user.signUp().isSuccess)
//        assert(user.save().isSuccess) //更新用户信息
    }
    
    class func login() {
        _ = LCUser.logIn(username: "liuheng368", password: "dashu365") { result in
            switch result {
            case .success(object: let user):
                print(user)
            case .failure(error: let error):
                print(error)
            }
        }
    }
}
