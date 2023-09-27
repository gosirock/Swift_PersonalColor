//
//  Detail_Review_List_Model.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/26.
//

import Foundation

class Detail_Review_List_Model{
    
    var documentID: String // FireBase 문서ID
    var review_documnentID: String
    var uid: String
    var review: String
    var time: String
    
    init(documentID: String, review_documnentID: String, uid: String, review: String, time: String) {
        self.documentID = documentID
        self.review_documnentID = review_documnentID
        self.uid = uid
        self.review = review
        self.time = time
    }
    
    
}
