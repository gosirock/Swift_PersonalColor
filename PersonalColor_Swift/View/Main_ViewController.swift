//
//  ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/19.
//

import UIKit
import KakaoSDKUser
class Main_ViewController: UIViewController {
    
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btn_kakao(_ sender: UIButton) {
        
        UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                    // 로그인성공시 이메일,닉네임,토큰가져오기
                    UserApi.shared.me { [self] user, error in
                        if let error = error {
                            print(error)
                        } else {
                            // 이메일, 토큰, 닉네임 제대로 들어오는지 확인
                            guard let token = oauthToken?.accessToken,
                                  let email = user?.kakaoAccount?.email,
                                  let name = user?.kakaoAccount?.profile?.nickname else{
                                      print("token/email/name is nil")
                                      return
                                  }
                            // 이메일, 토큰, 닉네임확인하기
                            print("-----------------------------------",email)
                            print(token)
                            print(name)
                            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarView")
                                    vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                                    vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                                    self.present(vcName!, animated: true, completion: nil)
                            // 일단 메인으로 가자...
                            // 세그이동시 오류 (화면뜨기전에 전환오류)
                            //self.performSegue(withIdentifier: "gogoMain", sender: self)
                            // present로 다음화면 띄우기 identifier : "abc" = 다음 탭바컨트롤러 이름
//                            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "abc") else {return}
//                            self.present(nextVC, animated: true)
                            //서버에 이메일/토큰/이름 보내주기
                        }
                    }
                }
            }
        
        
        
        
        
    }
    
    
    
    
    
    @IBAction func btnNaver(_ sender: UIButton) {
        
        
        // 메인페이지로 넘어가기
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarView")
                vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                self.present(vcName!, animated: true, completion: nil)
    }
    
    
}
