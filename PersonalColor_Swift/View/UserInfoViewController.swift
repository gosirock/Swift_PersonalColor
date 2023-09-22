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
    
    // user info : UserDBModel generic 배열
    var user : [UserDBModel] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(" user :  \(user)")
    }
    

    // 페이지 켜질 때 데이터 가져오기
    override func viewWillAppear(_ animated: Bool) {
        selectAction()
        
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
        
        
        
        
    }
    
    
}
