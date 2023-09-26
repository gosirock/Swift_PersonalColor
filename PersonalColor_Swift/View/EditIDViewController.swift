//
//  EditIDViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/23.
//

import UIKit

class EditIDViewController: UIViewController {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var vis: UIView!
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfPW: UITextField!
    @IBOutlet weak var tfPW2: UITextField!
    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var lblCorrect: UILabel!
    
    // user info : UserDBModel generic 배열
    var user : [UserDBModel] = []
    
    // 이미지 피커
    // 프로필이미지
    let imagePickerController = UIImagePickerController()
    
    var selectedImage : UIImage?
    
    // 비밀번호
    var passCorrect : Bool = false
    
    // 이미지
    var imageName : String = ""
    // 프로필사진을 바꿧는지 상태확인
    var imageInsert : Bool = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // readonly
        tfID.isUserInteractionEnabled = false
        
        
        // 비번 체크
        self.tfPW.addTarget(self, action: #selector(self.textFieldDidChanacge(_:)), for: .editingChanged)
        self.tfPW2.addTarget(self, action: #selector(self.textFieldDidChanacge(_:)), for: .editingChanged)
        
        setKeyBoadEvent()
        // 키보드 숨기기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        vis.addGestureRecognizer(tapGesture)
        
        // 원형이미지뷰
        imgView.layer.cornerRadius = imgView.frame.width / 2 // 정사각형 모양으로 만들기 위해 높이 대신 너비 사용
        imgView.layer.borderWidth = 2
        imgView.clipsToBounds = true
        //imgView.layer.borderColor = UIColor.blue.cgColor
        
        imgView.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
        
        //제스처인식기 생성
        let tapImageViewRecognizer
        = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
       //이미지뷰가 상호작용할 수 있게 설정
        imgView.isUserInteractionEnabled = true
       //이미지뷰에 제스처인식기 연결
        imgView.addGestureRecognizer(tapImageViewRecognizer)
        imagePickerController.delegate = self
    }
    
    // 페이지 켜질 때 데이터 가져오기
    override func viewWillAppear(_ animated: Bool) {
        selectAction()
        
        
        
    }
    
    
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        checkUpdate()
    }
    
    
    @IBAction func btnDelete(_ sender: UIButton) {
        showAlert()
 
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
    
    // 수정 가능여부 확인
    func checkUpdate(){
        guard let uid = tfID.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let upassword = tfPW.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let uname = tfName.text?.trimmingCharacters(in: .whitespaces) else {return}
        
        if (passCorrect && uid != "" && upassword != "" && uname != ""){
            if (validpassword(mypassword: upassword)&&validid(myid: uid)) {
                updateAction()
                if imageInsert{
                    
                }
            }else{
                showD()
            }
            
        }else{
            
        }
    }
    
    func showD(){
        let resultAlert = UIAlertController(title: "ERROR", message: "정보를 확인해주세요.", preferredStyle: .actionSheet)
        
        let onAction = UIAlertAction(title: "OK", style: .cancel)
        resultAlert.addAction(onAction)
        
        present(resultAlert, animated: true)
    }
    
    func updateAction(){
        let updateModel = UpdateModel()
        
        //guard let uid = tfID.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let upassword = tfPW.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let uname = tfName.text?.trimmingCharacters(in: .whitespaces) else {return}
        
        let result = updateModel.updateItem(UserDefaults.standard.string(forKey: "id")!, upassword, uname)
        
        if result{
            let resultAlert = UIAlertController(title: "UPDATE", message: "회원정보가 수정되었습니다.", preferredStyle: .actionSheet)
            
            let onAction = UIAlertAction(title: "OK", style: .default,handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            })
            resultAlert.addAction(onAction)
            
            present(resultAlert, animated: true)
        }else{
            let resultAlert = UIAlertController(title: "ERROR", message: "에러가 발생 되었습니다.", preferredStyle: .actionSheet)
            
            let onAction = UIAlertAction(title: "OK", style: .cancel)
            resultAlert.addAction(onAction)
            
            present(resultAlert, animated: true)
        }
        
    }
    
    
    func deleteAction(){
        let deleteModel = DeleteModel()
        
        
        let result = deleteModel.deleteItem(UserDefaults.standard.string(forKey: "id")!)
        
        if result{
            let resultAlert = UIAlertController(title: "Delete", message: "회원탈퇴가 완료되었습니다.", preferredStyle: .actionSheet)
            
            let onAction = UIAlertAction(title: "OK", style: .default,handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            })
            resultAlert.addAction(onAction)
            
            present(resultAlert, animated: true)
        }else{
            let resultAlert = UIAlertController(title: "ERROR", message: "에러가 발생 되었습니다.", preferredStyle: .actionSheet)
            
            let onAction = UIAlertAction(title: "OK", style: .cancel)
            resultAlert.addAction(onAction)
            
            present(resultAlert, animated: true)
        }
    }
    func showAlert(){
        // AlertController 초기화
        let testAlert = UIAlertController(title: "회원탈퇴", message: "정말로 탈퇴하시겠습니까 ? ", preferredStyle: .alert)
        
        
        // AlertAction 설정 ( 버튼 생성 )
        // 기본 글씨체
        let actionDefault = UIAlertAction(title: "취소", style: .default)
        // UIAlertController에 UIAlertAction 버튼추가하기
        testAlert.addAction(actionDefault)
        
        // 빨간 글씨체
        let actionDestructive = UIAlertAction(title: "탈퇴", style: .destructive, handler: {ACTION in
            self.deleteAction()
            
            
            // ACTION 이 Closure 기능을 포함하고 있음 ACTION in 하고 괄호사이에 코딩하면 됌
        })
        testAlert.addAction(actionDestructive)
        
        
        
        
        // alert 띄우기 present  barrier default
        present(testAlert, animated: true)
        
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
        // "@" 기호가 반드시 포함되어야 하고, 총 길이가 5에서 45 사이의 문자열을 체크하는 정규표현식
        let idreg = "^(?=.*[@])[A-Za-z0-9@#$%^&*!]{5,45}$"
        let idtesting = NSPredicate(format: "SELF MATCHES %@", idreg)
        return idtesting.evaluate(with: myid)
    }
    
    @objc func textFieldDidChanacge(_ sender: Any?) {
        let textCount = tfPW.text?.trimmingCharacters(in: .whitespaces)
        let textCount1 = tfPW2.text?.trimmingCharacters(in: .whitespaces)
        
        if textCount == textCount1{
            lblCorrect.text = "비밀번호가 일치합니다."
            passCorrect = true
            
        }else{
            lblCorrect.text = "비밀번호가 일치하지 않습니다."
            passCorrect = false
        }

           
       }
    
    // viewDidLoad에 setKeyBoadEvent 함수 실행
    func setKeyBoadEvent(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil  )
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisAppear(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil  )
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
    
    // 키보드 숨기기
    @objc func hideKeyboard() {
        view.endEditing(true)
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
    
    
} //EditIDViewController

extension EditIDViewController : QueryModelProtocol{
    func itemDownloaded(items : [UserDBModel]) {
        self.user = items
        tfID.text = user[0].uid
        tfName.text = user[0].uname
        tfPW.text = user[0].upassword
        tfPW2.text = user[0].upassword
        
        
        
    }
    
    
}
// image tap gesture
extension EditIDViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following : \(info)")
        }
        
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            let imgName = imageURL.lastPathComponent
            self.imageName = imgName
        }
        
        imgView.image = selectedImage
        self.selectedImage = selectedImage
        imageInsert = true
        dismiss(animated: true)
    }
    
}
