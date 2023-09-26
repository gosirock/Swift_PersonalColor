//
//  Insert_Board_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/25.
//

import UIKit
import PhotosUI // 앨범

class Insert_Board_ViewController: UIViewController {

    
    
    @IBOutlet var img: UIButton!
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var text_view: UITextView!
    
    // 앨범 사진 데이터 넣는곳
    var itemProviders: [NSItemProvider] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pre_setting()
    }
    
    func pre_setting(){
        // 업로드버튼 이미지 사이즈 맞추기
        img.imageView?.contentMode = .scaleAspectFit
        text_view.layer.borderWidth = 1
        text_view.layer.borderColor = UIColor.black.cgColor
    }

    
    
    @IBAction func btn_img(_ sender: UIButton) {
        presentPicker()
    }
    
    
    
    
    @IBAction func btn_add(_ sender: UIButton) {
        
     
        
        
        guard let imageData = self.img.imageView?.image?.pngData() else {return}
        guard let tfTitle_text = tfTitle.text else {return}
        
        let upload = Firebase_image_upload()
        upload.imageUpload(image: imageData, titleText: tfTitle_text, contentText: text_view.text, id: "hi")
        
        
    }
    
    
    
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
            self.img.imageView?.image = image
                }
            }
        }
    } // func addPreviewImage() End-
    

}




// 앨범
extension Insert_Board_ViewController: PHPickerViewControllerDelegate{

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
