//
//  KakaoLoginViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/11.
//

import UIKit
import KakaoSDKUser
import FirebaseAuth

class KakaoLoginViewController: UIViewController {
    private let kakaoLoginManager = KakaoLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kakaoLoginManager.loginWithKakaoAccount { oauthToken in
            _ = oauthToken
            
            self.kakaoLoginManager.getUserInfo()
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
