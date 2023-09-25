//
//  UserInfoViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/22.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var tfDate: UITextField!
    
    @IBOutlet weak var tfColor: UITextField!
    
    
    
    // user info : UserDBModel generic 배열
    var user : [UserDBModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        tfID.isUserInteractionEnabled = false
        tfName.isUserInteractionEnabled = false
        tfDate.isUserInteractionEnabled = false
        tfColor.isUserInteractionEnabled = false
    }
    
    
    // 페이지 켜질 때 데이터 가져오기
    override func viewWillAppear(_ animated: Bool) {
        selectAction()
        
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        print("Back")
    }
    
    // selectAction
    func selectAction(){
        user.removeAll()
        let queryModel = UserQueryModel()
        // extension 과 protocol이 연결
        queryModel.delegate = self
        // 데이터 가져와서 화면 구성
        print("ID:",UserDefaults.standard.string(forKey: "id")!)
        queryModel.downloadItems(id: UserDefaults.standard.string(forKey: "id")!)
        
        
        
    }
    
    
    
}// UIViewController


extension UserInfoViewController : QueryModelProtocol{
    func itemDownloaded(items : [UserDBModel]) {
        self.user = items
        tfID.text = user[0].uid
        tfName.text = user[0].uname
        tfDate.text = user[0].uinsertdate
        
        switch user[0].ucolor{
        case 0: tfColor.text = "봄 웜톤"
        case 1: tfColor.text = "여름 쿨톤"
        case 2: tfColor.text = "가을 웜톤"
        default: tfColor.text = "겨울 쿨톤"
        }
        
    }
    
    
}
