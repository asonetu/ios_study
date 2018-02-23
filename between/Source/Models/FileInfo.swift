//
//  FileInfo.swift
//  between
//
//  Created by 김홍식 on 2018. 2. 23..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import Foundation
import ObjectMapper

class FileInfo: Mappable {
    var fileId: Int?
    var fileName: String?
    var fileExt: String?
    var fileOriName: String?
    var base64Data: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        fileId <- map["fileId"]
        fileName <- map["fileName"]
        fileExt <- map["fileExt"]
        fileOriName <- map["fileOriName"]
        base64Data <- map["base64Data"]
    }
}

