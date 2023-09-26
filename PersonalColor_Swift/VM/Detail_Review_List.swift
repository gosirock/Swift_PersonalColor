//
//  Detail_Review_List.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/26.
//

import Foundation
import Firebase


protocol Detail_Review_List_Model_Protocol{
    func itemDownLoaded(items: [Detail_Review_List_Model])
} // protocol LJU_SelectModelProtocol End-

class Detail_Review_List{
    
    var delegate: Detail_Review_List_Model_Protocol!
    let db = Firestore.firestore()
    
    func downloadItems(review_documnentID:String){
        var locations: [Detail_Review_List_Model] = []
       
        db.collection("review")
            .whereField("review_documnentID", isEqualTo: review_documnentID)
            .order(by: "time", descending: true)
            .getDocuments(completion: {
                (querySnapshot,err) in
                // Error Check
                if (err != nil){
                    print("SelectModel Error")
                }else{
                    
                    print("SelectModel Success")
                    // FireBase Data를 DBModel Type으로 변환 및 locations에 넣기
                    for documnent in querySnapshot!.documents{
                        
                        let query = Detail_Review_List_Model(
                            documentID: documnent.documentID,
                            review_documnentID: documnent.data()["review_documnentID"] as! String,
                            uid: documnent.data()["id"] as! String,
                            review: documnent.data()["review_text"] as! String,
                            time: documnent.data()["time"] as! String
                            
                        )
                        locations.append(query)
                        print(locations[0].review_documnentID)
                    } // for End-
                    DispatchQueue.main.async {
                        self.delegate.itemDownLoaded(items: locations)
                    } // DispatchQueue End-
                } // if, else End-
            })// // FireBase Query getDocuments End-
    }
    
}
