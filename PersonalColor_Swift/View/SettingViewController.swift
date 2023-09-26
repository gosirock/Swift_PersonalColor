//
//  SettingViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/22.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    // 계정확인 뷰
    @IBOutlet weak var accountView: UIView!
    // 로그아웃 뷰
    @IBOutlet weak var logoutView: UIView!
    // 컬러 뷰
    @IBOutlet weak var colorView: UIView!
    // 추천 뷰
    @IBOutlet weak var recommendView: UIView!
    
    // SQLite DB에서 가져온 값 넣어두는 리스트
    //var imageList : [ImageModel] = []
    
    var userinfoList : [Image_DBModel] = []
    
    
    var user : [UserDBModel] = []
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
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
        
        // 계정확인 탭 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.accountView.addGestureRecognizer(tapGesture)
        
        // 로그아웃 제스쳐
        let tapLogOut = UITapGestureRecognizer(target: self, action: #selector(logoutTap(sender:)))
        self.logoutView.addGestureRecognizer(tapLogOut)
        
        // 컬러 뷰 제스쳐
        let cTap = UITapGestureRecognizer(target: self, action: #selector(colorTap(sender:)))
        self.colorView.addGestureRecognizer(cTap)
        
        // 추천 뷰 제스쳐
        let rTap = UITapGestureRecognizer(target: self, action: #selector(recommendTap(sender:)))
        self.recommendView.addGestureRecognizer(rTap)
        
        
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
    
    // 페이지 켜질 때 데이터 가져오기
    override func viewWillAppear(_ animated: Bool) {
        selectAction()
        readValues()
        //selectSQLite()
        
        
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
    
//    func selectSQLite(){
//        imageList.removeAll()
//        let database_Handler = DataBase_Handler_Wook()
//        database_Handler.delegate = self
//        database_Handler.selectAction(id: UserDefaults.standard.string(forKey: "id")!)
//    }
//
    
    
    // 3. this method is called when a tap is recognized
    @objc func handleTap(sender: UITapGestureRecognizer) {
        // 유저정보수정페이지로 넘어가기
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "userinfo")
        vc?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vc?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @objc func logoutTap(sender: UITapGestureRecognizer) {
        // 로그아웃 알림창
        showAlert()
        
    }
    
    @objc func colorTap(sender: UITapGestureRecognizer) {
        // 유저정보수정페이지로 넘어가기
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "color")
        vc2?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vc2?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
        self.present(vc2!, animated: true, completion: nil)
        
    }
    
    @objc func recommendTap(sender: UITapGestureRecognizer) {
        // 유저정보수정페이지로 넘어가기
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "recommend")
        vc3?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vc3?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
        self.present(vc3!, animated: true, completion: nil)
        
    }
    
    
    
    
    
    func showAlert(){
        // AlertController 초기화
        let testAlert = UIAlertController(title: "Log Out", message: "정말로 로그아웃하시겠습니까 ? ", preferredStyle: .alert)
        
        
        // AlertAction 설정 ( 버튼 생성 )
        // 기본 글씨체
        let actionDefault = UIAlertAction(title: "취소", style: .default)
        // UIAlertController에 UIAlertAction 버튼추가하기
        testAlert.addAction(actionDefault)
        
        // 빨간 글씨체
        let actionDestructive = UIAlertAction(title: "로그아웃", style: .destructive, handler: {ACTION in
            self.dismiss(animated: true, completion: nil)
            
            // ACTION 이 Closure 기능을 포함하고 있음 ACTION in 하고 괄호사이에 코딩하면 됌
        })
        testAlert.addAction(actionDestructive)
        
        
        
        
        // alert 띄우기 present  barrier default
        present(testAlert, animated: true)
        
    }
    
    
    // SelectModel에서 데이터 불러오기
    func readValues(){
        let selectModel = User_SelectModel()
        selectModel.delegate = self
        selectModel.downloadItems(tableName: "user",id : UserDefaults.standard.string(forKey: "id")!) // todolist Table 불러오기
        
    }
    
    
    
    
    
} //SettingViewController

extension SettingViewController : QueryModelProtocol{
    func itemDownloaded(items : [UserDBModel]) {
        self.user = items
        lblID.text = user[0].uid
        lblName.text = user[0].uname
    }
}


//extension SettingViewController : QueryModelProtocolWook{
//    func itemDownloaded(items: [ImageModel]) {
//        imageList = items
//        imgView.image = UIImage(data: imageList[0].imagefile)
//    }
//}


// selectProtocol
extension SettingViewController: User_SelectModelProtocols{
    func itemDownLoad(items: [Image_DBModel]){
        self.userinfoList = items
        
        // 이미지 넣어주기
        let url = URL(string: userinfoList[0].image)
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data)
                }
            }else{
                    print("이미지불러오기실패")
                }
        }
    }
    
}

