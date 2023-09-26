//
//  User_Select.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/26.
//

import Foundation
import Firebase

protocol User_SelectModelProtocols{
    func itemDownLoad(items: [Image_DBModel])
}

class User_SelectModel{
    
    var delegate: User_SelectModelProtocols!
    let db = Firestore.firestore()
    
    func downloadItems(tableName: String,id : String){
        var locations: [Image_DBModel] = []
        db.collection(tableName)
            .whereField("uid", isEqualTo: id)
            .order(by: "uinsertdate").getDocuments(completion: {
            (querySnapshot,err) in
                // Error Check
                if (err != nil){
                    print("Firebase Select Error")
                }else{
                    print("Firebase Select Success")
                    // FireBase Data를 DBModel Type으로 변환 및 locations에 넣기
                    for documnent in querySnapshot!.documents{
                        let query = Image_DBModel(
                            documentID: documnent.documentID,
                            image: documnent.data()["image"] as! String,
                            uid: documnent.data()["uid"] as! String,
                            upassword: documnent.data()["upassword"] as! String,
                            ustatus: documnent.data()["ustatus"] as! Int,
                            register_from: documnent.data()["register_from"] as! Int,
                            uinsertdate: documnent.data()["uinsertdate"] as! String,
                            uname: documnent.data()["uname"] as! String)
                        locations.append(query)
                    } // for End-
                    DispatchQueue.main.async {
                        self.delegate.itemDownLoad(items: locations)
                    } // DispatchQueue End-
                } // if, else End-
                })// // FireBase Query getDocuments End-
    } // func downloadItems End-
} // Class User_SelectModel End-
