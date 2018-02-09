//
//  NetworkManager.swift
//  between
//
//  Created by 김홍식 on 2018. 2. 10..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkManager {
    
    static let instance = NetworkManager();
    
    func request<T:Mappable>(url:String, method:HTTPMethod, param:Parameters, callback: @escaping (T?) -> ()) {
        
        let requestUrl = NetworkUtil.getServerUrl() + url;
        
        Alamofire.request(requestUrl,
                          method: method,
                          parameters: param,
                          encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<NetworkResponse<T>>) in
                
                let responseData = response.result.value
                print("responseCode: \(String(describing: responseData?.responseCode))");
                print("message: \(String(describing: responseData?.message))");
                
                let returnData:T? = (responseData?.data)!;
                callback(returnData);
        }
    }
    
    func get<T:Mappable>(url:String, param:Parameters, callback: @escaping (T?) -> ()) {
        request(url: url, method: .get, param: param, callback: callback);
    }
    
    func post<T:Mappable>(url:String, param:Parameters, callback: @escaping (T?) -> ()) {
        request(url: url, method: .post, param: param, callback: callback);
    }
    
    func put<T:Mappable>(url:String, param:Parameters, callback: @escaping (T?) -> ()) {
        request(url: url, method: .put, param: param, callback: callback);
    }
    
    func delete<T:Mappable>(url:String, param:Parameters, callback: @escaping (T?) -> ()) {
        request(url: url, method: .delete, param: param, callback: callback);
    }
}
