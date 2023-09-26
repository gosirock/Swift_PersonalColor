//
//  ImageDBModel.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/26.
//
import Foundation

// --- FireBase Data 담을 DataTypeClass
class Image_DBModel{
    
    var documentID: String // FireBase 문서ID
    var image: String // 이미지 URL
    var uid: String // 유저아이디
    var upassword: String // 유저비밀번호
    var ustatus: Int // 유저의 탈퇴여부  0: 회원, 1:탈퇴회원
    var ucolor: Int? // 색상 0:봄웜톤 , 1: 여름쿨톤, 2: 가을웜톤, 3: 겨울쿨톤
    var register_from: Int // 가입경로 , 0: 앱 내 회원가입, 1: 카카오회원가입, 2: 네이버회원가입
    var uinsertdate:String // 가입날짜
    var uname : String // 유저명
    var udeletedate:String? // 탈퇴날짜

    init(documentID: String, image: String, uid: String, upassword: String, ustatus: Int, register_from: Int, uinsertdate: String, uname: String) {
        self.documentID = documentID
        self.image = image
        self.uid = uid
        self.upassword = upassword
        self.ustatus = ustatus
        self.register_from = register_from
        self.uinsertdate = uinsertdate
        self.uname = uname
    }
}
