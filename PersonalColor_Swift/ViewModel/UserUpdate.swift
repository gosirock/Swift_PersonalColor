//
//  UserUpdate.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation
class UpdateModel{
    
    var urlPath = "http://localhost:8080/ios/studentUpdate_ios.jsp"
    
    func updateItem(_ code: String, _ name: String,_ dept: String,_ phone: String) ->Bool{
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
                print("Failed to update data")
                result = false
            }
        }
        return result
    }
}
