//
//  Board_review_list_model.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/26.
//

import Foundation

class Board_review_list_model{
    
    var documentID:String
    var id:String
    var review:String
    
    init(documentID: String, id: String, review: String) {
        self.documentID = documentID
        self.id = id
        self.review = review
    }
}
