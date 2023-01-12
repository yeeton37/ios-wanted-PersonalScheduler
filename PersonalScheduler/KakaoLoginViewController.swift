//
//  KakaoLoginViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/11.
//

import UIKit
import KakaoSDKUser

class KakaoLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
