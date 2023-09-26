//
//  Detail_Review_Delete.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/26.
//

import Foundation
import Firebase

class Detail_Review_Delete{
    
    var db = Firestore.firestore()
    
    func deleteItems(documentId: String){
        
        db.collection("review").document(documentId).delete(){
            error in
        } // FireBase Query Delete End-
        return
    } // func deleteItems End-
}
