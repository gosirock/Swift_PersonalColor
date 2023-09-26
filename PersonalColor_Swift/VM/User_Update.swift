//
//  User_Update.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/26.
//

import Foundation
import Firebase

class User_UpdateModel{
    
    
    var db = Firestore.firestore()
    
//    func updateItems(DocumentId: String, image:String, upassword:String, uname:String){
//
//
//        db.collection("user").document(DocumentId).updateData([
//            "image" : image,
//            "uname" : uname,
//            "upassword" : upassword
//        ]){error in
//            if error != nil{
//                print("Update fail")
//            }else{
//
//            }
//        }
//
//
//    }
//
    func updateItems(DocumentId: String, image:String, upassword:String, uname:String){
        db.collection("user").document(DocumentId).updateData([
            "image" : image,
            "uname" : uname,
            "upassword" : upassword,
        ]){error in
            if error != nil {
                print("Update fail")
            }else{
                print("Update success")
            }
        }
    }
    
    // todo완료 미완료 firebase
    func todoStatusUpdate(DocumentId: String, todoStatus:Bool){
        var status:Bool = false
        if todoStatus{
            status = false
        }else{
            status = true
        }
        
        
        db.collection("todolist").document(DocumentId).updateData([
            "todoStatus" : status
        ]){error in
            if error != nil{
                print("Update fail")
            }else{
   
            }
        }
        
    }
    // private y&n firebase
    func privateStatusUpdate(DocumentId: String, priateStatus:Bool){
        
        db.collection("todolist").document(DocumentId).updateData([
            "priateStatus" : priateStatus
        ]){error in
            if error != nil{
                print("Update fail")
            }else{
   
            }
        }
    }
    
    // 순서바꾸기
    func todolistMoveRow(DocumentId: String, sequence: Int){
        
        print(sequence)
        db.collection("todolist").document(DocumentId).updateData([
            "sequence" : sequence
        ]){error in
            if error != nil{
                print("Update fail")
            }else{
                
            }
        }
    }
    
    
}
