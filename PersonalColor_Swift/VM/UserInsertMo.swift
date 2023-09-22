//
//  UserInsert.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation

class UserInsert{
    
    var urlPath = "http://localhost:8080/swift/project/userInsert_ios.jsp"
    
    func insertItems(_ uid: String, _ upassword: String,_ uname: String) ->Bool{
        var result:Bool = true
        
        // 날짜를 문자 타입으로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 원하는 날짜 형식 지정

        let currentDate = Date() // 현재 날짜와 시간
        let dateString = dateFormatter.string(from: currentDate) // String type로 바뀐 날짜
        
        
        // register_from { 0 : app , 1 : kakao, 2: naver
        // app
        let urlAdd = "?uid=\(uid)&upassword=\(upassword)&register_from=\(0)&uinsertdate=\(dateString)&uname=\(uname)"
        
        // kakao
        //let urlAdd = "?uid=\(uid)&upassword=\(upassword)&register_from=\(1)&uinsertdate=\(dateString)&uname=\(uname)"
        
        //naveer
        //let urlAdd = "?uid=\(uid)&upassword=\(upassword)&register_from=\(2)&uinsertdate=\(dateString)&uname=\(uname)"
        
        
        urlPath = urlPath + urlAdd
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        let url: URL = URL(string: urlPath)!
        
        DispatchQueue.global().async {
            do{
                _ = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    result = true
                }
            }catch{
                print("Failed to insert data")
                result = false
            }
        }
        return result
    }
    
}
