//
//  User_Insert.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/26.
//

import Foundation
import Firebase

class User_InsertModel{
    
    let db = Firestore.firestore()
    
    func insertItems(image:String,uid:String,upassword:String, uname:String){
        
        // 날짜를 문자 타입으로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 원하는 날짜 형식 지정

        let currentDate = Date() // 현재 날짜와 시간
        let dateString = dateFormatter.string(from: currentDate) // String type로 바뀐 날짜

        
        db.collection("user").addDocument(data: [
            "image": image,
            "uid": uid,
            "upassword": upassword,
            "ustatus": 0,
            "register_from": 0,
            "uname": uname,
            "uinsertdate": dateString,  
        ]){error in
 
        } // // FireBase Query Insert End-

    } // func insertItems End-
} //class LJU_InsertModel End-
