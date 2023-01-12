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
                
                // 로그인 성공 시
                UserApi.shared.me { kuser, error in
                    if let error = error {
                        print("------KAKAO : user loading failed------")
                        print(error)
                    } else {
                        // 파이어베이스 유저 생성 (이메일로 회원가입)
                        Auth.auth().createUser(withEmail: (kuser?.kakaoAccount?.email)!, password: "\(String(describing: kuser?.id))") { result, error in
                            if let error = error {
                                print("파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                                
                                Auth.auth().signIn(withEmail: (kuser?.kakaoAccount?.email)!, password: "\(String(describing: kuser?.id))", completion: nil)
                            } else {
                                print("파이어베이스 사용자 생성")
                                let vc = MainViewController()
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
            }
            
        }
    }
}
