//
//  SignUpViewController.swift
//  between
//
//  Created by dong wook on 2018. 2. 1..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import UIKit
import Toaster
import Alamofire
import AlamofireObjectMapper

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var coupleEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        let userName:String = self.userNameTextField.text!
        let userEmail:String = self.userEmailTextField.text!
        let userPassword:String = self.userPasswordTextField.text!
        let coupleEmail:String = self.coupleEmailTextField.text!
        
        let isMyEmailAddressValid = CommonUtil.isValidEmailAddress(emailAddressString: userEmail)
        let isCoupleEmailAddressValid = CommonUtil.isValidEmailAddress(emailAddressString: coupleEmail)
        
        print("내 이름 :\(userName)")
        print("내 이메일 :\(userEmail)")
        print("비밀번호 :\(userPassword)")
        print("상대방 :\(coupleEmail)")
        
        if (userName.isEmpty || userEmail.isEmpty || userPassword.isEmpty || coupleEmail.isEmpty) {
            Toast(text: "모든 정보를 입력하세요.").show()
        } else if (!isMyEmailAddressValid || !isCoupleEmailAddressValid) {
            Toast(text: "이메일을 확인하세요.").show()
        } else {
            let param: Parameters = [
                "userName" : userName,
                "email" : userEmail,
                "password" : userPassword,
                "coupleEmail" : coupleEmail
            ]
            
            NetworkManager.instance.post(url:NetworkURL.signup, param:param, callback:{(result:LoginResult?) in
                let loginResultCode = result?.loginResultCode
                print("loginResultCode: \(String(describing: loginResultCode))")
                
                //loginResultCode가 SUCCESS 일때 이동
                if let loginCode = loginResultCode{
                    if loginCode == "SUCCESS" {
                        self.performSegue(withIdentifier: "goSignInIdentifier", sender: self)
                    }
                    else if loginCode == "WAITING" {
                        Toast(text: "상대방을 기다리는 중입니다.").show()
                    }
                    else if loginCode == "ALREADY_EXIST_EMAIL" {
                        Toast(text: "이미 존재하는 이메일입니다.").show()
                    }
                    else if loginCode == "INVALID_COUPLE_EMAIL" {
                        Toast(text: "INVALID_COUPLE_EMAIL").show()
                    }
                }
            });
        }
    }
}
