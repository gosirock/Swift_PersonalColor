//
//  DataBase_Handler.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/24.
//

import Foundation
import SQLite3

//protocol
protocol QueryModelProtocolWook{
    func itemDownloaded(items: [ImageModel])
}



class DataBase_Handler_Wook{
    
    // SQLite db OpaquePointer 는 C 언어
    var db : OpaquePointer?
    var colorList : [ImageModel] = []
    var delegate : QueryModelProtocolWook!
    
    
    init(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "ImageDB.sqlite") // .appending(path: "fileName") app 내 db의 fileName

        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK{
            print("error opening database")
        }
    }

    
    
    // DB 생성
    func createDB(){
        // Table 만들기
        // todo 라는 table을 만들어서 did , dimageName, dcontent를 column으로 넣기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS color (seq INTEGER PRIMARY KEY AUTOINCREMENT, uid TEXT,imageName TEXT,imagefile BLOB)", nil, nil, nil) != SQLITE_OK{
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error creating table : \(errMSG)")
            return
        }
    }
    
    // Select Action
    func selectAction(id:String){
        var stmt : OpaquePointer?
        // 한글정의
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        // DB 쿼리문
        //let queryString = "SELECT * FROM color"
        let queryString = "SELECT seq,uid,imageName,imageFile FROM color WHERE uid = ?"
        
        // 쿼리문 준비
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        // ?에 값 넣어주기
        print("id : \(id)")
        sqlite3_bind_text(stmt, 1, id, -1, SQLITE_TRANSIENT)
        
        // 조건 (sqlite3_step(stmt) == SQLITE_ROW ):  불러올 데이터가 있으면
        while(sqlite3_step(stmt) == SQLITE_ROW){
            // 0,1,2 는 db에서 컬럼의 순서
            let seq = Int(sqlite3_column_int(stmt,0))
            let uid = String(cString: sqlite3_column_text(stmt, 1))
            let imageName = String(cString: sqlite3_column_text(stmt, 2))
            let imageFile =  Data(bytes: sqlite3_column_blob(stmt, 3), count: Int(sqlite3_column_bytes(stmt, 3)))

            print("imageName:\(imageName)")
            colorList.append(ImageModel(seq: seq, uid: uid, imageName: imageName, imagefile: imageFile))
        }
        DispatchQueue.main.async {
            // delegate에 todoList 값을 넣어주기
            self.delegate?.itemDownloaded(items: self.colorList)
        }
    }
    
    
    // + 버튼 눌렀을 때 추가하기
    func insertAction(_ uid : String,_ imageName:String,_ image : Data){
        var stmt : OpaquePointer?
        // 한글정의
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO color (uid, imageName, imageFile) VALUES (?,?,?)"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        

        
        // Data type을 원시메모리로 바꾸기
        //let data: Data = // 여러분의 Data 객체
        //let rawPointer = data.withUnsafeBytes { $0.baseAddress }
        //let dataSize = data.count
        
        let rawPointer = image.withUnsafeBytes { $0.baseAddress }
        let dataSize = image.count
        
        
        // ? <- insert
        // stmt , ? 순서 , 내용 , -1 : 한글 , SQLITE_TRANSIENT
        sqlite3_bind_text(stmt, 1, uid, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, imageName, -1, SQLITE_TRANSIENT)
        sqlite3_bind_blob(stmt, 3, rawPointer, Int32(dataSize), nil)
        
        
        sqlite3_step(stmt)
    }
    
    // deleteAction
    func deleteAction(_ id:String){
        var stmt : OpaquePointer?
        // 한글정의
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        // 쿼리문
        let queryString = "DELETE FROM color WHERE uid = ?"
        // 쿼리 준비
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        // ?에 값 넣어주기
        sqlite3_bind_text(stmt, 1, id, -1, SQLITE_TRANSIENT)
        // 쿼리실행
        sqlite3_step(stmt)
    }
    
    
    // updateAction
    func updateAction(id : String,imageName : String,image : Data){
        
        var stmt : OpaquePointer?
        // 한글정의
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE color SET imageName = ?, imageFile = ? WHERE uid = ?"
        
        //  sqlite3_prepare(db, queryString, -1, &stmt, nil) 이것만 있어도됌
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        
        // Data type을 원시메모리로 바꾸기
        let rawPointer = image.withUnsafeBytes { $0.baseAddress }
        let dataSize = image.count
        
        
        
        // ? <- insert
        // stmt , ? 순서 , 내용 , -1 : 한글 , SQLITE_TRANSIENT
        sqlite3_bind_text(stmt, 1, imageName, -1, SQLITE_TRANSIENT)
        sqlite3_bind_blob(stmt, 2, rawPointer, Int32(dataSize), nil)
        sqlite3_bind_text(stmt, 3, id, -1, SQLITE_TRANSIENT)
        
        
        //sqlite3_bind_int(stmt, 4, Int32(id))
        
        //  sqlite3_step(stmt) 이것만 있어도됌
        sqlite3_step(stmt)
    }
    

    
    

}
