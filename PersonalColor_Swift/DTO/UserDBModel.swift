//
//  UserDBModel.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation
// db column과  달라도 됌
// User Model

class UserDBModel{
    
    // property
    var uid : String
    var upassword : String
    var ustatus : Int
    var ucolor : Int
    var uinsertdate : String
    var udeletedate : String?
    var uname : String
    
    
    init(uid: String, upassword: String, ustatus: Int, ucolor: Int, uinsertdate: String, udeletedate: String, uname: String) {
        self.uid = uid
        self.upassword = upassword
        self.ustatus = ustatus
        self.ucolor = ucolor
        self.uinsertdate = uinsertdate
        self.udeletedate = udeletedate
        self.uname = uname
    }
    
    
    init(uid: String, upassword: String, ustatus: Int, ucolor: Int, uinsertdate: String, uname: String) {
        self.uid = uid
        self.upassword = upassword
        self.ustatus = ustatus
        self.ucolor = ucolor
        self.uinsertdate = uinsertdate
        self.uname = uname
    }
    
}

class LoginUser{
    var rs : Int
    var ustatus : Int
    
    init(rs: Int, ustatus: Int) {
        self.rs = rs
        self.ustatus = ustatus
    }
}

class ColorQuery{
    var red : Int
    var green : Int
    var blue : Int
    var ucolor : Int
    
    init(red: Int, green: Int, blue: Int, ucolor: Int) {
        self.red = red
        self.green = green
        self.blue = blue
        self.ucolor = ucolor
    }
}


class ColorMessage{
    static var color : Int = 0
}
