//
//  AddUserViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/26.
//

import UIKit

class AddUserViewController: UIViewController {
        
        @IBOutlet weak var imgView: UIImageView!
        
        @IBOutlet weak var tfID: UITextField!
        @IBOutlet weak var tfPW: UITextField!
        @IBOutlet weak var tfPWcheck: UITextField!
        @IBOutlet weak var tfName: UITextField!
        
        @IBOutlet weak var lblCorrect: UILabel!
        var passCorrect : Bool = false
        
        // 프로필이미지
        let imagePickerController = UIImagePickerController()
        
        var selectedImage : UIImage?
        
        var imageName : String = ""
        // 프로필사진을 바꿧는지 상태확인
        var imageInsert : Bool = false
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            lblCorrect.text = ""
            // Do any additional setup after loading the view.
            
            // 비번 체크
            self.tfPW.addTarget(self, action: #selector(self.textFieldDidChanacge(_:)), for: .editingChanged)
            self.tfPWcheck.addTarget(self, action: #selector(self.textFieldDidChanacge(_:)), for: .editingChanged)
            
            
            //제스처인식기 생성
            let tapImageViewRecognizer
            = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
           //이미지뷰가 상호작용할 수 있게 설정
            imgView.isUserInteractionEnabled = true
           //이미지뷰에 제스처인식기 연결
            imgView.addGestureRecognizer(tapImageViewRecognizer)
            imagePickerController.delegate = self
            
            // 원형이미지뷰
            imgView.layer.cornerRadius = imgView.frame.width / 2 // 정사각형 모양으로 만들기 위해 높이 대신 너비 사용
            imgView.layer.borderWidth = 5
            imgView.clipsToBounds = true
            imgView.layer.borderColor = UIColor.systemPink.cgColor
            
            //imgView.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
            
            // 키보드 올림 내림함수
            setKeyBoadEvent()
        }
        

        @IBAction func btnRegister(_ sender: UIButton) {
            checkRegister()
            navigationController?.popViewController(animated: true)
        }
        
        // 회원가입 가능여부 확인
        func checkRegister(){
            guard let uid = tfID.text?.trimmingCharacters(in: .whitespaces) else {return}
            guard let upassword = tfPW.text?.trimmingCharacters(in: .whitespaces) else {return}
            guard let uname = tfName.text?.trimmingCharacters(in: .whitespaces) else {return}
            
            if (passCorrect && uid != "" && upassword != "" && uname != ""){
                if (validpassword(mypassword: upassword)&&validid(myid: uid)) {
                    tempInsert()
                    if imageInsert{
                        //insertImage(selectedImage!)
                        firebase_insertAction(selectedImage!)
                    }else{
                        //insertImage(UIImage(systemName: "person.fill")!)
                        firebase_insertAction(UIImage(systemName: "person.fill")!)
                    }
                    
                }else{
                    showD()
                }
                
            }else{
                
            }
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
                let resultAlert = UIAlertController(title: "ERROR", message: "정보를 확인해주세요.", preferredStyle: .actionSheet)
                let onAction = UIAlertAction(title: "OK", style: .cancel)
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true)
            }
            
        }
        
        @objc func textFieldDidChanacge(_ sender: Any?) {
            let textCount = tfPW.text?.trimmingCharacters(in: .whitespaces)
            let textCount1 = tfPWcheck.text?.trimmingCharacters(in: .whitespaces)
            
            if textCount == textCount1{
                lblCorrect.text = "비밀번호가 일치합니다."
                passCorrect = true
                
            }else{
                lblCorrect.text = "비밀번호가 일치하지 않습니다."
                passCorrect = false
            }

               
           }
        func showD(){
            let resultAlert = UIAlertController(title: "ERROR", message: "정보를 확인해주세요.", preferredStyle: .actionSheet)
            
            let onAction = UIAlertAction(title: "OK", style: .cancel)
            resultAlert.addAction(onAction)
            
            present(resultAlert, animated: true)
        }
        
        // 비밀번호 정규식
        func validpassword(mypassword : String) -> Bool
            {//(?=.*[A-Za-z])(?=.*[0-9])
                // 숫자, 문자, 특수 문자 중 최소 하나를 포함하고 4~20글자 사이의 text 체크하는 정규표현식
                let passwordreg = "^(?=.*[@#$%^&*!])[A-Za-z0-9@#$%^&*!]{4,20}$"
                let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
                return passwordtesting.evaluate(with: mypassword)
            }
        
        func validid(myid: String) -> Bool {
            // "@, ." 기호가 반드시 포함되어야 하고, 총 길이가 5에서 45 사이의 문자열을 체크하는 정규표현식
            let idreg = "^(?=.*[@])(?=.*[.])[A-Za-z0-9@#$%^&*!.]{5,45}$"
            let idtesting = NSPredicate(format: "SELF MATCHES %@", idreg)
            return idtesting.evaluate(with: myid)
        }
        
        //MARK: 이미지뷰 클릭시 호출될 함수
        @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
            enrollAlertEvent()
            
        }
        
        func enrollAlertEvent() {
            
            let alertController = UIAlertController(title: "앨범", message: "선택", preferredStyle: .alert)
            
                let photoLibraryAlertAction = UIAlertAction(title: "사진 앨범", style: .default) {
                    (action) in
                    self.openAlbum()
                }
                let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel)
                alertController.addAction(photoLibraryAlertAction)
                alertController.addAction(cancelAlertAction)
            
                present(alertController, animated: false)
        }
        
        
        
        
        func openAlbum() {
                imagePickerController.sourceType = .photoLibrary
                present(imagePickerController, animated: false)
        }
        
        
    //    func insertImage(_ image : UIImage){
    //        let database_Handler = DataBase_Handler_Wook()
    //
    //
    //        //UIImage -> Data
    //        let imageData: Data = image.pngData()! as Data
    //
    //        guard let id = tfID.text?.trimmingCharacters(in: .whitespaces) else{return}
    //        database_Handler.insertAction(id, imageName, imageData)
    //
    //
    //    }
        
        
        // InsertModel로 데이터 보내주기
        func firebase_insertAction(_ image : UIImage){
            
            // InsertModel 연결
            //let insertDB = User_InsertModel()
            let upload = User_ImageUpload()
            
            // preview text 체크
            guard let uid = tfID.text?.trimmingCharacters(in: .whitespaces) else {return}
            guard let upassword = tfPW.text?.trimmingCharacters(in: .whitespaces) else {return}
            guard let uname = tfName.text?.trimmingCharacters(in: .whitespaces) else {return}
            
            
            //이미지업로드
            //UIImage -> Data
            let imageData: Data = image.pngData()! as Data
            upload.imageUpload(image: imageData, uid: uid, upassword: upassword, uname: uname)
               
            print("firebase insert success")
            
        }
        
    // viewDidLoad에 setKeyBoadEvent 함수 실행
    func setKeyBoadEvent(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil  )
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisAppear(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil  )
    }
    
    // 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
        
    // 화면 올리기
    @objc func keyboardWillAppear(_ sender : NotificationCenter){
        // 메모리에 상주하면서 관찰하는 observer
        
        
        // 화면의 y값을 0 에서 -250 으로 바꾸기
        self.view.frame.origin.y = -250
    }
    
    // 화면 내리기
    @objc func keyboardWillDisAppear(_ sender : NotificationCenter){
        // 메모리에 상주하면서 관찰하는 observer
        
        
        // 화면의 y값을 0으로 바꾸기
        self.view.frame.origin.y = 0
    }

        
    }//AddUserViewController



    // image tap gesture
    extension AddUserViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
                fatalError("Expected a dictionary containing an image, but was provided the following : \(info)")
            }
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                let imgName = imageURL.lastPathComponent
                self.imageName = imgName
                print("Selected image file name: \(imageName)")
            }
            
            imgView.image = selectedImage
            self.selectedImage = selectedImage
            imageInsert = true
            dismiss(animated: true)
        }
        
    }



