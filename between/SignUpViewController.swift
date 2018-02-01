//
//  SignUpViewController.swift
//  between
//
//  Created by dong wook on 2018. 2. 1..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var coupleEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var myEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
         if let myEmail = self.myEmailTextField.text,
            let myPassword = self.passwordTextField.text,
            let coupleEmail = self.coupleEmailTextField.text{
            
            print("내 이메일 :\(myEmail)")
            print("비밀번호 :\(myPassword)")
            print("상대방 :\(coupleEmail)")
        
        }
    }
}
