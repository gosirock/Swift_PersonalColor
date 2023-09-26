//
//  Board_update.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/27.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class Board_update{
    
    
    let db = Firestore.firestore()
    
    func updateItems(documnetID: String, image:String, title:String, content:String){

        
        db.collection("board").document(documnetID).updateData([
            "image": image,
            "Title": title,
            "Content": content
           
        ]){error in
 
        } // // FireBase Query Insert End-

    } // func insertItems End-
}
