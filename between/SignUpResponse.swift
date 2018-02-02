//
//  SignUpResponse.swift
//  between
//
//  Created by dong wook on 2018. 2. 2..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import ObjectMapper

class SignUpResponse: Mappable {
    /*response
    {
    "responseCode": "200",
    "message": "SUCCESS",
    "data": {
    "loginResultCode": "ALREADY_EXIST_EMAIL",
    "user": {
    "userId": 0,
    "email": "test01@studybook.co.kr",
    "userName": "test01",
    "password": "test01",
    "coupleEmail": "test01@studybook.co.kr",
    "statusCode": null,
    "createDate": null,
    "nowDate": null
    }
    }
    }*/

    var responseCode: String?
    var message: String?
    var data: SignUpResultData?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        responseCode <- map["responseCode"]
        message <- map["message"]
        data <- map["data"]
    }
}

class SignUpResultData: Mappable {
    var loginResultCode: String?
    var user: User?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        loginResultCode <- map["loginResultCode"]
        user <- map["user"]
    }
}

//class User: Mappable {
//    var userId: String?
//    var email: String?
//    var userName: String?
//    var password: String?
//    var coupleEmail: String?
//    var statusCode: String?
//    var createDate: Date?
//    var nowDate: Date?
//
//    required init?(map: Map){
//
//    }
//
//    func mapping(map: Map) {
//        userId <- map["userId"]
//        email <- map["email"]
//        userName <- map["userName"]
//        password <- map["password"]
//        coupleEmail <- map["coupleEmail"]
//        statusCode <- map["statusCode"]
//        createDate <- map["createDate"]
//        nowDate <- map["nowDate"]
//    }
//}
//
