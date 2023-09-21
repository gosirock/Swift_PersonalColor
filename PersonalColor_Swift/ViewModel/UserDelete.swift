//
//  UserDelete.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation
class DeleteModel{
    var urlPath = "http://localhost:8080/ios/studentDelete_ios.jsp"
    
    func deleteItem(_ code: String, _ name: String,_ dept: String,_ phone: String) ->Bool{
        var result:Bool = true
        let urlAdd = "?code=\(code)&name=\(name)&dept=\(dept)&phone=\(phone)"
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
                print("Failed to delete data")
                result = false
            }
        }
        return result
    }
    
}
