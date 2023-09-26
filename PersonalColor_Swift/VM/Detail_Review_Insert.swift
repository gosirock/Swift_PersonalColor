//
//  Detail_Review_Insert.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/26.
//

import Foundation
import Firebase


class Detail_Review_Insert{
    
    
    let db = Firestore.firestore()
    
    func insertItems(review_documnetID:String, review_text:String){

        // 오늘 날짜시간
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = date.string(from: Date())
        
        db.collection("review").addDocument(data: [
            "review_documnentID": review_documnetID,
            "review_text": review_text,
            "id": UserDefaults.standard.string(forKey: "id")!,
            "time": now,
        ]){error in
 
        } // // FireBase Query Insert End-

    } // func insertItems End-
}
