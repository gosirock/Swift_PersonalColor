//
//  PC_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/20.
//

import UIKit
import PhotosUI

class PC_ViewController: UIViewController {
 
    
    // 앨범이미지 담는곳~
    var itemProviders: [NSItemProvider] = []
    
    @IBOutlet var img_upload: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btn_Slect_photo(_ sender: UIButton) {
        presentPicker()
        
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
        
    }
} // func addPreviewImage() End-

-
+    // 이미지 flask 전송
+//    func sendImageToServer(image: UIImage) {
+//        let serverURL = URL(string: "http://127.0.0.1:5000/rbg")! // Flask 서버 엔드포인트
+//
+//        // 이미지를 Data로 변환
+//        if let imageData = image.jpegData(compressionQuality: 1.0) {
+//            var request = URLRequest(url: serverURL)
+//            request.httpMethod = "POST"
+//
+//            // 이미지 데이터를 요청 본문에 추가
+//            request.httpBody = imageData
+//
+//            // Content-Type 헤더 설정
+//            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
+//
+//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
+//                if let error = error {
+//                    print("Error: \(error)")
+//                    return
+//                }
+//
+//                if let data = data {
+//                    do {
+//                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
+//                            if let rgbValues = json["rgb"] as? [Int] {
+//                                // 서버에서 받은 RGB 값 처리
+//                                print("Received RGB values: \(rgbValues)")
+//                            }
+//                        }
+//                    } catch {
+//                        print("Error parsing JSON: \(error)")
+//                    }
+//                }
+//            }
+//
+//            task.resume()
+//        }
+//    }

}



// 앨범
-extension PC_ViewController: PHPickerViewControllerDelegate{
-
-        // picker가 종료되면 동작 함
-        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
+// 앨범
+extension PC_ViewController: PHPickerViewControllerDelegate {
+    // picker가 종료되면 동작 함
+    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
+
+        // picker가 선택이 완료되면 화면 내리기
+        picker.dismiss(animated: true)
+
+        // 만들어준 itemProviders에 Picker로 선택한 이미지정보를 전달
+        itemProviders = results.map(\.itemProvider)
+
+        // 앨범에서 이미지 선택시 imgview에 보이기
+        if !itemProviders.isEmpty {
+            addPreviewImage()
        
-            // picker가 선택이 완료되면 화면 내리기
-            picker.dismiss(animated: true)
+            // 이미지가 골라지면 정면사진인지 확인
+            if let image = img_upload.image {
+                sendImageToServer(image: image)
+            }
+        }
+    }
+
+    // 이미지를 Flask 서버로 전송
+    func sendImageToServer(image: UIImage) {
+        let serverURL = URL(string: "http://127.0.0.1:5000/rgb")! // Flask 서버 엔드포인트
+
+        // 이미지를 Data로 변환
+        if let imageData = image.jpegData(compressionQuality: 1.0) {
+            var request = URLRequest(url: serverURL)
+            request.httpMethod = "POST"
+
+            // 이미지 데이터를 요청 본문에 추가
+            request.httpBody = imageData
        
-            // 만들어준 itemProviders에 Picker로 선택한 이미지정보를 전달
-            itemProviders = results.map(\.itemProvider)
+            // Content-Type 헤더 설정
+            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        
-            // 앨범에서 이미지 선택시 imgview에 보이기
-            if !itemProviders.isEmpty {
-                        addPreviewImage()
+            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
+                if let error = error {
+                    print("Error: \(error)")
+                    return
+                }
+
+                if let data = data {
+                    do {
+                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
+                            if let rgbValues = json["rgb"] as? [Int] {
+                                // 서버에서 받은 RGB 값 처리
+                                print("Received RGB values: \(rgbValues)")
+                            }
+                        }
+                    } catch {
+                        print("Error parsing JSON: \(error)")
                }
+                }
+            }
+
+            task.resume()
    }
-} // 앨범끗
+    }
+}// 앨범

