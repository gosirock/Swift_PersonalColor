//
//  Detail_Board_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/22.
//

import UIKit

class Detail_Board_ViewController: UIViewController {

    var id:String = ""
    var title_text:String = ""
    var content_text:String = ""
    var image_data:String = ""
    var documentID:String = ""
    
    var list_data:[Detail_Review_List_Model] = []
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tvContent: UITextView!
    
    
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var tfReview: UITextField!
    
    
    
    @IBOutlet var tableView: UITableView!
    
    
    
    @IBOutlet var btnEdit: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        var docidCheck = Board_Message.detail_DocumentID
        if !docidCheck{
            self.navigationController?.popViewController(animated: true)
        }else{
            if id != UserDefaults.standard.string(forKey: "id")!{
                btnEdit.isHidden = true
            }
            readValues()
            // 키보드위치에 따른 화면이동
            
            
            setKeyboardEvent()
            
            //id = UserDefaults.standard.string(forKey: "id")!
            // 이미지주소 data로 바꾸기
        }
        
        
        
    }
    func readValues(){
        
   
        let detailModel = Detail_View_Query()
        detailModel.delegate = self
        var check = detailModel.downloadItems(documnetID: documentID)
        
        
        let selectModel = Detail_Review_List()
        selectModel.delegate = self
        selectModel.downloadItems(review_documnentID: documentID)
        tableView.reloadData()
        
      
    }
    
    

    
    @IBAction func btnReview(_ sender: UIButton) {
        
        guard let reviewText = tfReview.text else {return}
        
        if reviewText.trimmingCharacters(in: .whitespaces).isEmpty{
            callAlert(alert_title: "Error", alert_Message: "Plase Enter Content", tfName: "text_view")
            return
        }
        
        let insertAction = Detail_Review_Insert()
        insertAction.insertItems(review_documnetID: documentID, review_text: tfReview.text!)
        tfReview.text?.removeAll()
        readValues()
    }
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "update" {
            
            let updateView = segue.destination as! Board_Update_ViewController
            updateView.titleText = title_text
            updateView.contentText = content_text
            updateView.img = image_data
            updateView.documentID = documentID
        }
     
    }
        
        
        // Alert 띄우기
        func callAlert(alert_title:String, alert_Message: String, tfName: String){
            
            let alert = UIAlertController(title: alert_title, message: alert_Message, preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "Ok", style: .default,handler: {
                ACTION in
                switch tfName{
                default: self.tfReview.becomeFirstResponder()
                    
                }
                
                
            } )
            
            alert.addAction(yes)
            present(alert, animated: true)
        } // func callAlert End-
        
        
    // Cell안에 버튼 함수
    @objc func cellBtnClick(sender: UIButton){

        let review_deleteAction = Detail_Review_Delete()
        review_deleteAction.deleteItems(documentId: list_data[sender.tag].documentID)
        readValues()
    }
    

    // 키보드 외부 클릭시 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    // 키보드에 따른 화면옮기기
    func setKeyboardEvent(){
            // 키보드가 생성될때
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
            // 키보드가 사라질때
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
            
        
        }
        
        @objc func keyboardWillAppear(_ sender: NotificationCenter){
            // 본인의 뷰의 틀의 원본의 Y값 = -150
            self.view.frame.origin.y = -190
        }

        @objc func keyboardWillDisappear(_ sender:NotificationCenter){
            self.view.frame.origin.y = 0
        }
    // 키보드에 따른 화면 옮기기 끗
    
    
    
    
    
}


extension Detail_Board_ViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! Detail_Board_TableViewCell
        
        cell.lblText.text = list_data[indexPath.row].review
        cell.lbltime.text = list_data[indexPath.row].time
        
      
        if list_data[indexPath.row].uid == UserDefaults.standard.string(forKey: "id")!{
            cell.btnDelete.isHidden = false
        }else{
            cell.btnDelete.isHidden = true
        }
        
        
        // cell안의 버튼의 태그에 indexPath.row 넣기
        cell.btnDelete.tag = indexPath.row
        // cell안의 버튼함수 호출, 터치업이벤트
        cell.btnDelete.addTarget(self, action: #selector(cellBtnClick(sender:)), for: .touchUpInside)
        
        
        
        
        
        return cell
    }
    
    
}


extension Detail_Board_ViewController:Detail_Review_List_Model_Protocol{
    func itemDownLoaded(items: [Detail_Review_List_Model]) {
        // self 전역변수 todolist_data에 itmes 넣기
        list_data = items
        // data는 들어갔으니 TableView 화면 재구성하기
        self.tableView.reloadData()

    }
}


extension Detail_Board_ViewController:Detail_View_Model_Protocol{
    func itemDownLoaded(items: [Board_List_Model]) {
      
        
        documentID = items[0].documentID
        id = items[0].id
        title_text = items[0].title
        content_text = items[0].content
        image_data = items[0].image
        lblTitle.text = title_text
        tvContent.text = content_text
     
        let url = URL(string: image_data)
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){
                DispatchQueue.main.async {
                    self.img.image = UIImage(data: data)
                }
            }else{
                    print("이미지불러오기실패")
                }
        }
        
    }
}
