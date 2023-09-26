//
//  PC_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/20.
//

import UIKit
import PhotosUI

class PC_ViewController: UIViewController {
    
    // 카메라 셋팅
    let imgPicker = UIImagePickerController()
    // popup
    var popupStatus = false
    
    
    @IBOutlet var img_upload: UIImageView!
    @IBOutlet weak var indicator_loding: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate = self
        indicator_loding.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_Slect_photo(_ sender: UIButton) {
        // 앨범, 카메라
        choicePhoto()
    }
    
    // 앨범, 카메라 선택
    func choicePhoto(){
        let alert =  UIAlertController(title: "PHOTO", message: "정면으로 된 사진으로 골라주세요!!", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "앨범에서 가져오기", style: .default, handler: {ACTION in
            self.openLibrary()
        })
        let camera =  UIAlertAction(title: "카메라", style: .default, handler: {ACTION in
            self.openCamera()
        })
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    // 라이브러리(앨범)
    func openLibrary(){
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: false, completion: nil)
    }
    
    // 카메라 설정
    func openCamera(){
        imgPicker.sourceType = .camera
        imgPicker.allowsEditing = true
        imgPicker.cameraDevice = .rear
        imgPicker.cameraCaptureMode = .photo
        imgPicker.delegate = self
        present(imgPicker, animated: true, completion: nil)
    }
    
    // 얼굴인식 오류 일떼
    func notFase(){
        let alert =  UIAlertController(title: "얼굴인식 오류", message: "정면으로 된 사진으로 골라주세요!!", preferredStyle: .alert)
        popupStatus = true
        present(alert, animated: true, completion: nil)
    }
    
    // 다른 부분 터치시 alert창 종료
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        if popupStatus{
            dismiss(animated: true, completion: nil)
            popupStatus = true
        }
    }

    
    // 이미지를 서버로 업로드 , VM으로 이동 시켜야되는 부분
    func uploadImageToServer(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let serverURL = URL(string: "http://127.0.0.1:5000/ai/personalcolor")! // Flask 서버 엔드포인트
            var request = URLRequest(url: serverURL)
            request.httpMethod = "POST" // POST 요청으로 수정
            request.httpBody = imageData
            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type") // Content-Type 설정
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    // 200 통신 성공 시
                    if httpResponse.statusCode == 200 {
                        print("Review deleted successfully")
                        if let data = data {
                            // 서버에서 반환한 데이터를 처리합니다.
                            DispatchQueue.global().async {
                                
                                let data = Data(data) // 데이터가 있으면 가져옵니다.
                                DispatchQueue.main.async {
                                    // loding
                                    self.indicator_loding.isHidden = false
                                    self.indicator_loding.startAnimating()
                                    
                                    // 받아온 데이터 처리 작업
                                    self.handleServerResponse(data)
                                }
                            }
                        }
                    } else {
                        // alart 띄어줘야됨 <<<<<<<<<<<<<<<<<<<<<<<<<<<
                        print("Failed to delete review. Status code: \(httpResponse.statusCode)")
                        DispatchQueue.main.async {
                            // UI 업데이트 코드 작성
                            self.notFase()
                        }
                        return
                    }
                }
                
                
            }.resume() // URLSession 태스크 실행
        }
    }// 서버 업로드 끝

    
    // 서버에서 데이터 받아오기
    func handleServerResponse(_ data: Data?) {
        guard let data = data else {
            print("Error: No data received from server")
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                DispatchQueue.main.async {
                    self.indicator_loding.isHidden = true
                    self.indicator_loding.stopAnimating()
                    
                    // 퍼스널 컬러 데이터
                    if let pcType = json["result"] as? String {
                        //self.personalColor(pcType)
                        
                        // PCT_ViewController 인스턴스 생성
                        let pctViewController = self.storyboard?.instantiateViewController(identifier: "pctview") as? PCT_ViewController
                        
                        // 데이터를 뷰 컨트롤러의 프로퍼티에 할당
                        pctViewController?.name = pcType
                        
                        // 모달로 화면 전환
                        pctViewController?.modalPresentationStyle = .overFullScreen
                        
                        // 모달 이벤트
                        pctViewController?.modalTransitionStyle = .crossDissolve

                        // 모달 띄우기
                        self.present(pctViewController ?? UIViewController(), animated: true)
                    }
                    
                    // rgb 데이터
                    if let rgb = json["rgb"] {
                        print(rgb)
                    }
                }
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }

    }// 서버에서 데이터 받아오기 끝, VM이동 끝
    

    
    
} // VIEW END

// 선택한 이미지를 가져와 이미지 뷰에 설정
extension PC_ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            img_upload.image = image
            uploadImageToServer(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

    
