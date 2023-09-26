//
//  firebase_image_upload.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/25.
//

import Foundation
import Firebase
import FirebaseStorage

class Firebase_image_upload{
    
    func imageUpload(image: Data, titleText: String, contentText: String, id: String){
        print("이미지업로드")
        // 오늘 날짜시간 file명으로 바꾸기
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fileName = date.string(from: Date())
        
        
        let storage = Storage.storage().reference()
        // 파일명
        let riversRef = storage.child("images/\(fileName).png")
        
        let uploadTask = riversRef.putData(image, metadata: nil) {(metadata,error) in
            guard let metadata = metadata else {
                
                return
            }
            
            riversRef.downloadURL {(url, error) in
                guard let downloadURL = url else{

                    return
                }

                let image:String = url!.absoluteString
                let insertDB = Board_insert()
                insertDB.insertItems(image: image, title: titleText, content: contentText, id: id, time: fileName)
            }
            
        }
        
        
        
    }
}
