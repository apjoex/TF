//
//  UserData.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 8/9/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import Foundation

class UserData {
    
    var name : String
    var email : String
    var uid : String

    
    init(uid:String, name:String, email:String) {
        self.uid = uid
        self.name = name
        self.email = email
    }
    
    
    var dict:[String : Any] {
        return [
            "uid": self.uid,
            "email": self.email,
            "name":self.name
            
        ]
    }
}
