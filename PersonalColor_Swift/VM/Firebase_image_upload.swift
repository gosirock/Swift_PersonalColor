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
        
        // 오늘 날짜시간 file명으로 바꾸기
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fileName = date.string(from: Date())
        
        
        let storage = Storage.storage().reference()
        // 파일명
        let riversRef = storage.child("images/\(fileName).png")
        
        _ = riversRef.putData(image, metadata: nil) {(metadata,error) in
            guard metadata != nil else {
                
                return
            }
            
            riversRef.downloadURL {(url, error) in
                guard url != nil else{

                    return
                }

                let image:String = url!.absoluteString
                let insertDB = Board_insert()
                insertDB.insertItems(image: image, title: titleText, content: contentText, id: id, time: fileName)
            }
            
        }
        
        
        
    }
    
    func updateimageUpload(documnetID: String,image: Data, titleText: String, contentText: String){
        
        // 오늘 날짜시간 file명으로 바꾸기
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fileName = date.string(from: Date())
        
        
        let storage = Storage.storage().reference()
        // 파일명
        let riversRef = storage.child("images/\(fileName).png")
        
        _ = riversRef.putData(image, metadata: nil) {(metadata,error) in
            guard metadata != nil else {
                
                return
            }
            
            riversRef.downloadURL {(url, error) in
                guard url != nil else{

                    return
                }

                let image:String = url!.absoluteString
                let updateDB = Board_update()
                updateDB.updateItems(documnetID: documnetID, image: image, title: titleText, content: contentText)
                
            }
            
        }
        
        
        
    }
}
