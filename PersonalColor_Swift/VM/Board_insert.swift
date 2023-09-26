//
//  Board_insert.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/25.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class Board_insert{
    
    
    let db = Firestore.firestore()
    
    func insertItems(image:String, title:String, content:String, id:String, time:String){

        print("인설트")
        db.collection("board").addDocument(data: [
            "image": image,
            "Title": title,
            "Content": content,
            "id": id,
            "time": time,
        ]){error in
 
        } // // FireBase Query Insert End-

    } // func insertItems End-
}
