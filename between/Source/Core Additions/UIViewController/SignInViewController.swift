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

class SignInViewController: UIViewController {
    @IBOutlet weak var roundedCornerBtn: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedCornerBtn.layer.cornerRadius = 5
        // Do any additional setup after loading the view, typically from a nib.
        
        let keychain = Keychain(service: "com.ios.study.between")
        
        let email = keychain["email"]
        let password = keychain["password"]
        
        print("keychain email: \(String(describing: email))")
        print("keychain password: \(String(describing: password))")
        
        if(email != nil && password != nil) {
            if(email != "" && password != "") {
                login(email: email!, password: password!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login(email: String, password: String) {
        
        print("login email: \(email), password: \(password)")
        
        let param: Parameters = [
            "email" : email,
            "password" : password
        ]
        
        NetworkManager.instance.post(url:NetworkURL.signin, param:param, callback:{(result:LoginResult?) in
            let loginResultCode = result?.loginResultCode;
            print("loginResultCode: \(String(describing: loginResultCode))");
            
            if(loginResultCode == "SUCCESS") {
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                
                let keychain = Keychain(service: "com.ios.study.between")
                keychain["email"] = self.email.text
                keychain["password"] = self.password.text
                
                let user = result?.user;
                print("userId: \(String(describing: user?.userId))")
                print("email: \(String(describing: user?.email))")
                
                let userId:Int = (user?.userId)!;
                keychain["userId"] = String(userId);
                
            } else if(loginResultCode == "INVALID_ACCOUNT" || loginResultCode == "INVALID_PASSWORD") {
                Toast(text: "이메일 주소, 암호를 확인해주세요.").show()
            } else if(loginResultCode == "WAITING") {
                Toast(text: "상대방을 기다리는 중입니다.").show()
            }
        });
    }
    
    @IBAction func onClickLoginButton(_ sender: Any) {
        
        let email:String = self.email.text!;
        let password:String = self.password.text!;
        
        let isEmailAddressValid = CommonUtil.isValidEmailAddress(emailAddressString: email);
        if(isEmailAddressValid) {
            login(email: email, password: password);
        } else {
            Toast(text: "이메일을 확인하세요.").show();
        }
    }
}
    

