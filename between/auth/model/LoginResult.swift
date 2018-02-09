//
//  LoginResponse.swift
//  between
//
//  Created by 김홍식 on 2018. 1. 30..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import ObjectMapper

class LoginResult: Mappable {
    var loginResultCode: String?
    var user: User?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        loginResultCode <- map["loginResultCode"]
        user <- map["user"]
    }
}
