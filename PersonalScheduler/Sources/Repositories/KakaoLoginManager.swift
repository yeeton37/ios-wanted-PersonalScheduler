//
//  KakaoLoginManager.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/13.
//

import Foundation
import FirebaseAuth
import KakaoSDKUser
import KakaoSDKAuth

class KakaoLoginManager {
    func loginWithKakaoAccount(completion: @escaping (OAuthToken?) -> Void) {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else {
                print("loginWithKakaoAccount() success.")
                completion(oauthToken)
            }
        }
    }
    
    func getUserInfo(completion: @escaping (AuthDataResult?) -> Void) {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            
            Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                if let error = error {
                    print("파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                    
                    Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))", completion: nil)
                } else {
                    print("파이어베이스 사용자 생성")
                    completion(result)
                }
            }
        }
    }
}
