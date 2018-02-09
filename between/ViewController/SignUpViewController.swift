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
        
         if let userName = self.userNameTextField.text,
            let userEmail = self.userEmailTextField.text,
            let userPassword = self.userPasswordTextField.text,
            let coupleEmail = self.coupleEmailTextField.text{
            
            if !userName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !coupleEmail.isEmpty{
            let isMyEmailAddressValid = isValidEmailAddress(emailAddressString: userEmail)
            
            let isCoupleEmailAddressValid = isValidEmailAddress(emailAddressString: coupleEmail)
            
            print("내 이름 :\(userName)")
            print("내 이메일 :\(userEmail)")
            print("비밀번호 :\(userPassword)")
            print("상대방 :\(coupleEmail)")
            
            if isMyEmailAddressValid && isCoupleEmailAddressValid {
             
                let parameters: Parameters = [
                    "userName" : userName,
                    "email" : userEmail,
                    "password" : userPassword,
                    "coupleEmail" : coupleEmail
                ]
                
                let signUpUrl = "http://studybook.co.kr:8080/between/v1/auth/signup"
                
                Alamofire.request(signUpUrl, method: .post, parameters: parameters,encoding: JSONEncoding.default)
                    .responseObject{(response: DataResponse<LoginResponse>) in
                        let signUpResponse = response.result.value
                        print("responseCode: \(String(describing: signUpResponse?.responseCode))")
                        print("message: \(String(describing: signUpResponse?.message))")
                        let loginResultCode = signUpResponse?.data?.loginResultCode
                        print("loginResultCode: \(String(describing: loginResultCode))")
                        
                        //loginResultCode가 SUCCESS 일때 이동
                        if let loginCode = loginResultCode{
                            if loginCode == "SUCCESS"{
                                self.performSegue(withIdentifier: "goProfileIdentifier", sender: self)
                            }
                        }
                }
            }
            else{
                 Toast(text: "이메일을 확인하세요.").show()
            }
        }
         else{
            Toast(text: "모든 정보를 입력하세요.").show()
        }
        }
    }
    
    //이메일 유효성 검사 함수
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
}
