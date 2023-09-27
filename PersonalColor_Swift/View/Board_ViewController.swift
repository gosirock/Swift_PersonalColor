//
//  Board_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/22.
//

import UIKit

class Board_ViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    var collection_data:[Board_List_Model] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readValues()
        
    }
    
    func readValues(){
        
   
        let selectModel = Board_List()
        selectModel.delegate = self
        selectModel.downloadItems(tableName: "board") // todolist Table 불러오기
        collectionView.reloadData()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "review" {
            let cell = sender as! Cell_Board_CollectionView
            let indexPath = collectionView.indexPath(for: cell)
            let detailView = segue.destination as! Detail_Board_ViewController
            detailView.documentID = collection_data[indexPath!.row].documentID
            detailView.id = collection_data[indexPath!.row].id
            
            Board_Message.detail_DocumentID = true
            

        }
        
        
      
    }
    
    
    
    
    
}



extension Board_ViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    
    // Cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection_data.count
    }
    
    // cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! Cell_Board_CollectionView
        
        // 셀 배경화면
//        cell.backgroundColor = .white
        let frame_list = ["frame01","frame02","frame03","frame04",]
        cell.board_frame.image = UIImage(named: frame_list[indexPath.row % 4])
        // 셀 타이틀이름
        cell.board_label.text = collection_data[indexPath.row].title
        // 이미지주소 data로 바꾸기
        let url = URL(string: collection_data[indexPath.row].image)
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){
                DispatchQueue.main.async {
                    cell.board_img.image = UIImage(data: data)
                }
            }else{
                    print("이미지불러오기실패")
                }
        }
        return cell
                                                      
    }
    
    // Click Event
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

// CollectionView 모양 간격
extension Board_ViewController:UICollectionViewDelegateFlowLayout{
    // 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 150 // 1픽셀 띄우겠다
    }
    // 좌우 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }

//    // Cell Size (옆 라인을 고려하여 설정)
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width / 3 - 1
//        let size = CGSize(width: width, height: width)
//        return size
//    }

}


extension Board_ViewController:Board_List_Model_Protocol{
    func itemDownLoaded(items: [Board_List_Model]) {
        // self 전역변수 todolist_data에 itmes 넣기
        collection_data = items
        // data는 들어갔으니 TableView 화면 재구성하기
        self.collectionView.reloadData()
    }
}


