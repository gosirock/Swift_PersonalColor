//
//  Board_List.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/25.
//

import Foundation
import Firebase

protocol Board_List_Model_Protocol{
    func itemDownLoaded(items: [Board_List_Model])
} // protocol LJU_SelectModelProtocol End-

class Board_List{
    
    var delegate: Board_List_Model_Protocol!
    let db = Firestore.firestore()
    
    func downloadItems(tableName: String){
        var locations: [Board_List_Model] = []
        print("tableName =",tableName)
        db.collection(tableName)
            .getDocuments(completion: {
            (querySnapshot,err) in
                // Error Check
                if (err != nil){
                    print("SelectModel Error")
                }else{
                    
                    print("SelectModel Success")
                    // FireBase Data를 DBModel Type으로 변환 및 locations에 넣기
                    for documnent in querySnapshot!.documents{
                        let query = Board_List_Model(
                            documentID: documnent.documentID,
                            image: documnent.data()["image"] as! String,
                            title: documnent.data()["Title"] as! String,
                            content: documnent.data()["Content"] as! String,
                            id: documnent.data()["id"] as! String,
                            time: documnent.data()["time"] as! String
                            )
                        locations.append(query)
                       
                    } // for End-
                    DispatchQueue.main.async {
                        self.delegate.itemDownLoaded(items: locations)
                    } // DispatchQueue End-
                } // if, else End-
            })// // FireBase Query getDocuments End-
    }
    
}
