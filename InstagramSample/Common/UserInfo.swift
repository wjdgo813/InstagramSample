//
//  UserInfo.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 10/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

struct UserInfo {
    static var token: String{
        set(newVal){
            UserDefaults.standard.setValue(newVal, forKey: "AccessToken")
        }
        get{
            if let token = UserDefaults.standard.object(forKey: "AccessToken") as? String {
                return token
            }
            return ""
        }
    }
}
