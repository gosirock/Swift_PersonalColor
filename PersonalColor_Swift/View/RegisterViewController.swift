//
//  RegisterViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import UIKit

class RegisterViewController: UIViewController {

    
    
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfPW: UITextField!
    @IBOutlet weak var tfPWcheck: UITextField!
    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnRegister(_ sender: UIButton) {
        tempInsert()
        navigationController?.popViewController(animated: true)
    }
    
    // insertAction
    func tempInsert() {
        let insertModel = UserInsert()
        
        guard let uid = tfID.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let upassword = tfPW.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let uname = tfName.text?.trimmingCharacters(in: .whitespaces) else {return}
        
        let result = insertModel.insertItems(uid, upassword, uname)
        
        if result{
            let resultAlert = UIAlertController(title: "완료", message: "입력이 되었습니다.", preferredStyle: .actionSheet)
            
            let onAction = UIAlertAction(title: "OK", style: .default,handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            
            present(resultAlert, animated: true)
        }else{
            let resultAlert = UIAlertController(title: "ERROR", message: "에러가 발생 되었습니다.", preferredStyle: .alert)
            
            let onAction = UIAlertAction(title: "OK", style: .cancel)
            resultAlert.addAction(onAction)
            
            present(resultAlert, animated: true)
        }

    }
}//RegisterViewController
