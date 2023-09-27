//
//  Board_Delete.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/27.
//

import Foundation


import Foundation
import Firebase

class Board_Delete{
    
    var db = Firestore.firestore()
    
    func deleteItems(documentId: String){
        
        db.collection("board").document(documentId).delete(){
            error in
        } // FireBase Query Delete End-
        
        return
    } // func deleteItems End-
}

