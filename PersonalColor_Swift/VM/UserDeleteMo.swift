//
//  UserDelete.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation
class DeleteModel{
    var urlPath = "http://localhost:8080/swift/project/user_delete.jsp"
    
    
    
    
    func deleteItem(_ uid : String) ->Bool{
        
        // 날짜를 문자 타입으로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 원하는 날짜 형식 지정

        let currentDate = Date() // 현재 날짜와 시간
        let dateString = dateFormatter.string(from: currentDate) // String type로 바뀐 날짜
        print("ID = \(uid)")
        print("udeletedate = \(dateString)")
        
        var result:Bool = true
        let urlAdd = "?uid=\(uid)&udeletedate=\(dateString)"
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
                print("Failed to update data")
                result = false
            }
        }
        return result
        }

        
        
        
        
}
