//
//  LoginResponse.swift
//  between
//
//  Created by 김홍식 on 2018. 1. 30..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import ObjectMapper

class LoginResponse: Mappable {
    /*
     {
         "responseCode": "200",
         "message": "SUCCESS",
         "data": {
             "loginResultCode": "WAITING",
             "user": {
                 "userId": 15,
                 "email": "test23@studybook.co.kr",
                 "userName": "test23",
                 "password": "test23",
                 "coupleEmail": "test24@studybook.co.kr",
                 "statusCode": "01",
                 "createDate": 1516959122000,
                 "nowDate": 1517273921000
             }
         }
     }
     */
    var responseCode: String?
    var message: String?
    var data: LoginResultData?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        responseCode <- map["responseCode"]
        message <- map["message"]
        data <- map["data"]
    }
}

class LoginResultData: Mappable {
    var loginResultCode: String?
    var user: User?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        loginResultCode <- map["loginResultCode"]
        user <- map["user"]
    }
}

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
