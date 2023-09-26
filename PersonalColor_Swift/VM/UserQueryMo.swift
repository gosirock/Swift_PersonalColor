//
//  UserQuery.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation
// View Model
// JSON 에서 데이터를 받아오기

// DBModel에서 값을 받아와서 protocol에 저장해주고
// itemDownloaded를 테이블에서 실행해서 값을 가져가는것이다.
protocol QueryModelProtocol{
   func itemDownloaded(items : [UserDBModel])
}

protocol LoginModelProtocol{
   func itemDownloaded(items : [LoginUser])
}

protocol ColorModelProtocol{
   func itemDownloaded(items : [ColorQuery])
}

class UserQueryModel{
   var delegate : QueryModelProtocol!
   
   // [ {key:value} ] 형태 데e이터가져오기
   var urlPath  = "http://localhost:8080/swift/project/user_query_ios.jsp"
   
   
   // {result: [  {key:value } ] } 형태 데이터 가져오기
   //let urlPath  = "http://localhost:8080/swift/project/user_query_ios.jsp"
   
   
   // 데이터 가져오는 함수
   
    func downloadItems(id : String){
       // dispatch , async
        urlPath = urlPath + "?uid=\(id)"
       let url : URL = URL(string : urlPath)!
       
       
       //DispatchQueue global 은 1,2페이지 둘다 작동, main은 보이는 페이지만 작동
       // DispatchQueue.global.async : Future async
       // DispatchQueue.main.async : await
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.parseJSON(data)
                }
            } catch {
                // 오류 처리
                print("Error: \(error)")
                // 필요한 오류 처리 로직을 여기에 추가하세요.
            }
        }

       
   }
   
   
   func parseJSON(_ data:Data){
       // 가져오는지 확인하기
       // JSON to String
       //        let str = String(decoding: data, as: UTF8.self)
       //        print(str)
       
       
       
       let docoder = JSONDecoder()
       var locations : [UserDBModel] = []
       
       do{
           // users에 가져온 데이터를 디코딩해서 넣기
           
           
           // [{key:value}]
           let users = try docoder.decode([UserJSON2].self, from: data)
           
           
           for user in users{ // for in 문 범위에서 students / students.results
               let query = UserDBModel(uid: user.uid, upassword: user.upassword, ustatus: user.ustatus, ucolor: user.ucolor, uinsertdate: user.uinsertdate, uname: user.uname)

               // static에 ucolor넣어두기
               let message = ColorMessage.self
               message.color = query.ucolor
               print("가져온색상:\(query.ucolor)")
               locations.append(query)
               // 배열에 가져온 값을 넣어주기
           }
           print(locations)
           
           // 가져온 값 갯수 확인
           print(users.count)
           
           
       }catch let error{
           print("Fail : \(error.localizedDescription)")
       }
       
       // protocol에 받아온 데이터값 넣어주기  => protocol에 값 넣어주기
       DispatchQueue.main.async {
           // 가져온 데이터를 넣어둔 locations를 delegate에 넣어줌 -- 2
           self.delegate.itemDownloaded(items: locations)
           
           
       }
       
   }
   
} // class


class LoginCheck{
   var delegate : LoginModelProtocol!
   
   // [ {key:value} ] 형태 데e이터가져오기
   var urlPath  = "http://localhost:8080/swift/project/login_check2.jsp"
   
   
   // {result: [  {key:value } ] } 형태 데이터 가져오기
   //let urlPath  = "http://localhost:8080/swift/project/login_check2.jsp"
   
   
   // 데이터 가져오는 함수
   
    func downloadItems(id : String, pw : String){
       // dispatch , async
        urlPath = urlPath + "?uid=\(id)&upassword=\(pw)"
       let url : URL = URL(string : urlPath)!
       
       
       //DispatchQueue global 은 1,2페이지 둘다 작동, main은 보이는 페이지만 작동
       // DispatchQueue.global.async : Future async
       // DispatchQueue.main.async : await
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.parseJSON(data)
                }
            } catch {
                // 오류 처리
                print("Error: \(error)")
                // 필요한 오류 처리 로직을 여기에 추가하세요.
            }
        }

       
   }
    func parseJSON(_ data:Data){
        // 가져오는지 확인하기
        // JSON to String
//                let str = String(decoding: data, as: UTF8.self)
//                print(str)
        
        
        
        let docoder = JSONDecoder()
        var locations : [LoginUser] = []
        
        do{
            // users에 가져온 데이터를 디코딩해서 넣기
            
            // [{key:value}]
            let users = try docoder.decode([Login].self, from: data)
            
            
            for user in users{ // for in 문 범위에서 students / students.results
                let query = LoginUser(rs: user.count, ustatus: user.ustatus)
                locations.append(query)
                // 배열에 가져온 값을 넣어주기
            }
            //print(locations)
            
            // 가져온 값 갯수 확인
            //print(users.count)
            
            
        }catch let error{
            print("Fail : \(error.localizedDescription)")
        }
        
        // protocol에 받아온 데이터값 넣어주기  => protocol에 값 넣어주기
        DispatchQueue.main.async {
            // 가져온 데이터를 넣어둔 locations를 delegate에 넣어줌 -- 2
            self.delegate.itemDownloaded(items: locations)
            
            
        }
        
    }
   // 로그인체크 rowCount 1개만 가져오기
//   func parseJSON(_ data:Data){
//       // 가져오는지 확인하기
//       // JSON to String
//       print("-----")
//       let str = String(decoding: data, as: UTF8.self)
//       let trimmedStr = str.replacingOccurrences(of: "\n", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
//       print(trimmedStr)
//
//
//
//       let docoder = JSONDecoder()
//       var locations : [LoginUser] = []
//       let query = LoginUser(rs: trimmedStr)
//       locations.append(query)
//
//
//
//
//       // protocol에 받아온 데이터값 넣어주기  => protocol에 값 넣어주기
//       DispatchQueue.main.async {
//           // 가져온 데이터를 넣어둔 locations를 delegate에 넣어줌 -- 2
//           self.delegate.itemDownloaded(items: locations)
//
//
//       }
//
//   }
   
} // class


class ColorSelect{
   var delegate : ColorModelProtocol!
   
   // [ {key:value} ] 형태 데e이터가져오기
   var urlPath  = "http://localhost:8080/swift/project/color_select.jsp"
   
   // 데이터 가져오는 함수
   
    func downloadItems(id : String){
       // dispatch , async
        urlPath = urlPath + "?uid=\(id)"
       let url : URL = URL(string : urlPath)!
       
       
       //DispatchQueue global 은 1,2페이지 둘다 작동, main은 보이는 페이지만 작동
       // DispatchQueue.global.async : Future async
       // DispatchQueue.main.async : await
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.parseJSON(data)
                }
            } catch {
                // 오류 처리
                print("Error: \(error)")
                // 필요한 오류 처리 로직을 여기에 추가하세요.
            }
        }

       
   }
    func parseJSON(_ data:Data){
        // 가져오는지 확인하기
        // JSON to String
        print("가져왔나 ?")
                let str = String(decoding: data, as: UTF8.self)
                print(str)
        
        
        
        let docoder = JSONDecoder()
        var locations : [ColorQuery] = []
        
        do{
            // users에 가져온 데이터를 디코딩해서 넣기
            
            // [{key:value}]
            let users = try docoder.decode([Colors].self, from: data)
            
            
            for user in users{ // for in 문 범위에서 students / students.results
                let query = ColorQuery(red: user.red, green: user.green, blue: user.blue, ucolor: user.ucolor)
                

                locations.append(query)
                // 배열에 가져온 값을 넣어주기
            }

        }catch let error{
            print("Fail : \(error.localizedDescription)")
        }
        
        // protocol에 받아온 데이터값 넣어주기  => protocol에 값 넣어주기
        DispatchQueue.main.async {
            // 가져온 데이터를 넣어둔 locations를 delegate에 넣어줌 -- 2
            self.delegate.itemDownloaded(items: locations)
            
            
        }
        
    }
  
   
} // class

