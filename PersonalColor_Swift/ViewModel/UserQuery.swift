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

class UserQueryModel{
   var delegate : QueryModelProtocol!
   
   // [ {key:value} ] 형태 데e이터가져오기
   //let urlPath  = "https://zeushahn.github.io/Test/ios/student.json"
   
   
   // {result: [  {key:value } ] } 형태 데이터 가져오기
   let urlPath  = "https://zeushahn.github.io/Test/student.json"
   
   
   // 데이터 가져오는 함수
   
   func downloadItems(){
       // dispatch , async
       
       let url : URL = URL(string : urlPath)!
       
       
       //DispatchQueue global 은 1,2페이지 둘다 작동, main은 보이는 페이지만 작동
       // DispatchQueue.global.async : Future async
       // DispatchQueue.main.async : await
       DispatchQueue.global().async {
           // 데이터 가져오기   try도 async
           let data = try? Data(contentsOf: url)
           DispatchQueue.main.async {
               self.parseJSON(data!)
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
           // students에 가져온 데이터를 디코딩해서 넣기
           
           
           // [{key:value}]
           let users = try docoder.decode([UserJSON].self, from: data)
           
           // {results : [{key:value}]}
//           let users = try docoder.decode(UserResult.self, from: data)
           
           
           for user in users{ // for in 문 범위에서 students / students.results
               let query = UserDBModel(uid: user.uid, upassword: user.upassword, ustatus: user.ustatus, ucolor: user.ucolor, uinsertdate: user.uinsertdate, udeletedate: user.udeletedate, uname: user.uname)
               locations.append(query)
               // 배열에 가져온 값을 넣어주기
           }
           print(locations)
           
           // 가져온 값 갯수 확인
           //print(students.count)
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
   
}
