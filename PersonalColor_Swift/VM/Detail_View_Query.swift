//
//  Detail_View_Query.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/27.
//

import Foundation
import Firebase

protocol Detail_View_Model_Protocol{
    func itemDownLoaded(items: [Board_List_Model])
} // protocol LJU_SelectModelProtocol End-

class Detail_View_Query{
    
    var delegate: Detail_View_Model_Protocol!
    let db = Firestore.firestore()
    
    func downloadItems(documnetID:String){
 
        
        var locations: [Board_List_Model] = []
        
        db.collection("board").document(documnetID)
            .getDocument(completion: {
                (querySnapshot,err) in
                // Error Check
                if (err != nil){
                    print("SelectModel Error")
                }else{
                        let query = Board_List_Model(
                            documentID: querySnapshot?.documentID ?? "false",
                            image: querySnapshot?.data()?["image"] as! String,
                            title: querySnapshot?.data()?["Title"] as! String,
                            content: querySnapshot?.data()?["Content"] as! String,
                            id: querySnapshot?.data()?["id"] as! String,
                            time: querySnapshot?.data()?["time"] as! String
                        )
                        locations.append(query)
                    
                 

                    DispatchQueue.main.async {
                        self.delegate.itemDownLoaded(items: locations)
                    }
                        
                  
                         
                } // if, else End-
            })// // FireBase Query getDocuments End-
       
        
    
    }
    
}
