//
//  UserUpdate.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation
class UpdateModel{
    
    var urlPath = "http://localhost:8080/swift/project/user_update_ios.jsp"
    
    func updateItem(_ uid : String, _ upassword: String, _ uname: String) ->Bool{
        var result:Bool = true
        let urlAdd = "?upassword=\(upassword)&uname=\(uname)&uid=\(uid)"
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

class ColorUpdateModel{
    
    var urlPath = "http://localhost:8080/swift/project/color_insert.jsp"
    
    func colorInsert(_ red : Int, _ green: Int, _ blue: Int,_ ucolor : Int, _ uid : String) ->Bool{
        var result:Bool = true
        let urlAdd = "?red=\(red)&green=\(green)&blue=\(blue)&ucolor=\(ucolor)&uid=\(uid)"
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
