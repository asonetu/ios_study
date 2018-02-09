//
//  Response.swift
//  between
//
//  Created by 김홍식 on 2018. 2. 10..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import ObjectMapper

class NetworkResponse<T:Mappable>: Mappable {
   
    var responseCode: String?
    var message: String?
    var data: T?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        responseCode <- map["responseCode"]
        message <- map["message"]
        data <- map["data"]
    }
}
