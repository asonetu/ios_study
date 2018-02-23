//
//  NetworkUtil.swift
//  between
//
//  Created by 김홍식 on 2018. 2. 10..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import Foundation

class NetworkUtil {
    
    static func getServerUrl() -> String {
        
        var serverUrl = NetworkConstant.serverProtocol + "://" + NetworkConstant.serverHost;
        if(NetworkConstant.serverPort != "80") {
            serverUrl = serverUrl + ":" + NetworkConstant.serverPort;
        }
        
        serverUrl = serverUrl + "/" + NetworkConstant.serverContext + "/" + NetworkConstant.serverApiVersion;
        
        return serverUrl;
    }
}
