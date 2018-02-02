//
//  User.swift
//  between
//
//  Created by dong wook on 2018. 2. 2..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var userId: String?
    var email: String?
    var userName: String?
    var password: String?
    var coupleEmail: String?
    var statusCode: String?
    var createDate: Date?
    var nowDate: Date?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        email <- map["email"]
        userName <- map["userName"]
        password <- map["password"]
        coupleEmail <- map["coupleEmail"]
        statusCode <- map["statusCode"]
        createDate <- map["createDate"]
        nowDate <- map["nowDate"]
    }
}
