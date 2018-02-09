//
//  LoginViewController.swift
//  between
//
//  Created by 김홍식 on 2018. 1. 26..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Toaster
import KeychainAccess

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let keychain = Keychain(service: "com.ios.study.between")
        
        let email = keychain["email"]
        let password = keychain["password"]
        
        print("keychain email: \(String(describing: email))")
        print("keychain password: \(String(describing: password))")
        
        if(email != nil && password != nil) {
            login(email: email!, password: password!)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login(email: String, password: String) {
        
        print("login email: \(email), password: \(password)")
        
        let parameters: Parameters = [
            "email" : email,
            "password" : password
        ]
        
        let loginUrl = "http://studybook.co.kr:8080/between/v1/auth/signin"
        
        Alamofire.request(loginUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<LoginResponse>) in
                
                let loginResponse = response.result.value
                print("responseCode: \(String(describing: loginResponse?.responseCode))")
                print("message: \(String(describing: loginResponse?.message))")
                let loginResultCode = loginResponse?.data?.loginResultCode
                print("loginResultCode: \(String(describing: loginResultCode))")
                
                if(loginResultCode == "SUCCESS") {
                    self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                    
                    let keychain = Keychain(service: "com.ios.study.between")
                    keychain["email"] = self.email.text
                    keychain["password"] = self.password.text
                    
                    let user = loginResponse?.data?.user
                    keychain["userId"] = user?.userId
                    
                } else if(loginResultCode == "INVALID_ACCOUNT" || loginResultCode == "INVALID_PASSWORD") {
                    Toast(text: "이메일 주소, 암호를 확인해주세요.").show()
                } else if(loginResultCode == "WAITING") {
                    Toast(text: "상대방을 기다리는 중입니다.").show()
                }
                /*
                 let user = loginResponse?.data?.user
                 print("userId: \(String(describing: user?.userId))")
                 print("email: \(String(describing: user?.email))")
                 print("userName: \(String(describing: user?.userName))")
                 print("password: \(String(describing: user?.password))")
                 print("coupleEmail: \(String(describing: user?.coupleEmail))")
                 print("statusCode: \(String(describing: user?.statusCode))")
                 print("createDate: \(String(describing: user?.createDate))")
                 print("nowDate: \(String(describing: user?.nowDate))")
                 */
        }
    }
    
    @IBAction func onClickLoginButton(_ sender: Any) {
        
        let email = self.email.text
        let password = self.password.text
        
        login(email: email!, password: password!)
    }
}
    

