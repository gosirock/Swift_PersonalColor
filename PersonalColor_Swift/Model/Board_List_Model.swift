//
//  Board_List_Model.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/25.
//

import Foundation

class Board_List_Model{
    
    var documentID: String = "" // FireBase 문서ID
    var image: String // 이미지 URL
    var title: String // TodoList 제목
    var content: String // 내용
    var id: String // 완료&미완료
    var time: String
    
    init(documentID: String, image: String, title: String, content: String, id: String, time: String) {
        self.documentID = documentID
        self.image = image
        self.title = title
        self.content = content
        self.id = id
        self.time = time
    }
    
}
