//
//  ProfileViewController.swift
//  between
//
//  Created by 김홍식 on 2018. 2. 23..
//  Copyright © 2018년 김홍식. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import KeychainAccess

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2;
        self.profileImageView.clipsToBounds = true;
        
        let keychain = Keychain(service: "com.ios.study.between")
        let userId = keychain["userId"]
        
        print("keychain userId: \(String(describing: userId))")
        
        let param: Parameters = [
            "userId" : userId!
        ]
        
        print("param: \(String(describing: param))")
        
        NetworkManager.instance.get(url: NetworkURL.getUserProfile, param: param, encoding: URLEncoding(destination: .queryString), callback:{(result:User?) in
            let profileFileId = result?.profileFileId;
            self.downloadUserProfileImage(profileFileId: profileFileId!);
        });
    }
    
    func downloadUserProfileImage(profileFileId:Int) {
        
        let param: Parameters = [
            "fileId" : profileFileId
        ]
        
        NetworkManager.instance.get(url: NetworkURL.downloadUserProfileImage, param: param, encoding: URLEncoding(destination: .queryString), callback: {(result:FileInfo?) in
            let base64Data:String = (result?.base64Data!)!;
            let dataDecoded : Data = Data(base64Encoded: base64Data, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            self.profileImageView.image = decodedimage;
        });
    }
}

