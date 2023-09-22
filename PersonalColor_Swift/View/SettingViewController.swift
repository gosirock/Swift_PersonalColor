//
//  SettingViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/22.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var accountView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UIImage(named: "b3.png")
        //imgView.image = UIImage(systemName: "pencil")
        imgView.layer.cornerRadius = imgView.frame.width / 2 // 정사각형 모양으로 만들기 위해 높이 대신 너비 사용
        imgView.layer.borderWidth = 2
        imgView.clipsToBounds = true
        //imgView.layer.borderColor = UIColor.blue.cgColor

        imgView.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
        // Do any additional setup after loading the view.
        
        // 1. create a gesture recognizer (tap gesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        // 2. add the gesture recognizer to a view
        self.accountView.addGestureRecognizer(tapGesture)
        
        
        // shared preference
        if let storedUserName = UserDefaults.standard.string(forKey: "id") {
            // UserDefaults에서 "userName" 키로 저장된 문자열을 불러옴
            // storedUserName에 저장된 값이 옵셔널 형식이므로 nil 여부를 확인할 수 있음
            print("Stored User Name: \(storedUserName)")
        } else {
            // UserDefaults에 "userName" 키로 저장된 값이 없거나 nil일 경우에 대한 처리
            print("User Name is not stored in UserDefaults.")
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // 3. this method is called when a tap is recognized
    @objc func handleTap(sender: UITapGestureRecognizer) {
        // 유저정보수정페이지로 넘어가기
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "userinfo")
        vc?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vc?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                self.present(vc!, animated: true, completion: nil)
        
    }

    
    
}
