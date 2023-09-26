//
//  Board_Update_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/26.
//

import UIKit
import PhotosUI // 앨범
class Board_Update_ViewController: UIViewController {

    
    var img:String = ""
    var titleText:String = ""
    var contentText:String = ""
    var documentID:String = ""
    
    // 앨범 사진 데이터 넣는곳
    var itemProviders: [NSItemProvider] = []
    var imageCheck:Bool = false
    
    
    @IBOutlet var btn_img: UIButton!
    
    
    @IBOutlet var tfTitle: UITextField!
    
    @IBOutlet var tvContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(documentID)
        imageCheck = false
        tfTitle.text = titleText
        tvContent.text = contentText
        btn_img.imageView?.contentMode = .scaleToFill
        
        let url = URL(string: img)
    
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){
                DispatchQueue.main.async {

                    self.btn_img.setBackgroundImage(UIImage(data: data), for: .normal)
                    
                }
            }else{
                    print("이미지불러오기실패")
                }
        }
        
    }
    
    
    @IBAction func btn_image(_ sender: UIButton) {
        presentPicker()
    }
    
    

    @IBAction func btn_update(_ sender: UIButton) {
        
        
        guard let tfTitle_text = tfTitle.text else {return}
        guard let tvContent_text = tvContent.text else {return}
        
        
        
        if tfTitle_text.trimmingCharacters(in: .whitespaces).isEmpty{
            callAlert(alert_title: "Error", alert_Message: "Plase Enter Title", tfName: "title")
            return
        }
        if tvContent_text.trimmingCharacters(in: .whitespaces).isEmpty{
            callAlert(alert_title: "Error", alert_Message: "Plase Enter Content", tfName: "text_view")
            return
        }
        
        
        
        
        if imageCheck{
            guard let imageData = self.btn_img.backgroundImage(for: .normal)!.pngData() else {return}
            let upload = Firebase_image_upload()
            upload.updateimageUpload(documnetID: documentID, image: imageData, titleText: tfTitle_text, contentText: tvContent.text)
        }else{
            let update = Board_update()
            update.updateItems(documnetID: documentID, image: img, title: tfTitle_text, content: tvContent.text)
        }
        
        
        callAlert(alert_title: "Update Complete", alert_Message: "Your Content has been Update", tfName: "update")
      
    }
    
    // Alert 띄우기
    func callAlert(alert_title:String, alert_Message: String, tfName: String){
        
        let alert = UIAlertController(title: alert_title, message: alert_Message, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Ok", style: .default,handler: {
            ACTION in
            switch tfName{
            case "image": self.presentPicker()
            case "title": self.tfTitle.becomeFirstResponder()
            case "update" : self.navigationController?.popViewController(animated: true)
            default: self.tvContent.becomeFirstResponder()
                
            }
            
            
        } )
        
        alert.addAction(yes)
        present(alert, animated: true)
    } // func callAlert End-
    
    // 앨범띄우기
    func presentPicker() {
        
        // PHPickerConfiguration 생성 및 정의
        var config = PHPickerConfiguration()
        
        // 라이브러리에서 보여줄 Assets을 필터를 한다. (기본값: 이미지, 비디오, 라이브포토)
        config.filter = .images
        
        // 다중 선택 갯수 설정 (0 = 무제한)
        config.selectionLimit = 1
        
        // 컨트롤러 연결
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        
        // 앨범띄우기
        self.present(imagePicker, animated: true)
        
    } // func presentPicker() End-

    // 앨범선택사진 img에 띄우기
    func addPreviewImage(){
        
        
        // 사진이 한 개이므로 first로 접근하여 itemProvider를 생성
        guard let itemProvider = itemProviders.first else { return }
        
        // 만약 itemProvider에서 UIImage로 로드가 가능하다면?
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
        // 로드 핸들러를 통해 UIImage를 처리해 줍시다.
        itemProvider.loadObject(ofClass: UIImage.self) {
            [weak self] image, error in
                
            guard let self = self,
            let image = image as? UIImage else { return }
            
        // loadObject가 비동기적으로 처리되기 때문에 UI 업데이트를 위해 메인쓰레드로 변경
        DispatchQueue.main.async {
            //self.btn_img.imageView?.image = image
            self.btn_img.setBackgroundImage(image, for: .normal)
                }
            }
            imageCheck = true
        }
    } // func addPreviewImage() End-
    
}




// 앨범
extension Board_Update_ViewController: PHPickerViewControllerDelegate{

        // picker가 종료되면 동작 함
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // picker가 선택이 완료되면 화면 내리기
            picker.dismiss(animated: true)
            
            // 만들어준 itemProviders에 Picker로 선택한 이미지정보를 전달
            itemProviders = results.map(\.itemProvider)
            
            // 앨범에서 이미지 선택시 imgview에 보이기
            if !itemProviders.isEmpty {
                        addPreviewImage()
                    }
        }
} // 앨범끗
