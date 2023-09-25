//
//  Board_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/22.
//

import UIKit

class Board_ViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    let dataArray = ["g","g","a", "gg", "gg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "review" {
            let cell = sender as! Cell_Board_CollectionView
            let indexPath = collectionView.indexPath(for: cell)
            let detailView = segue.destination as! Detail_Board_ViewController
            detailView.name = dataArray[indexPath!.row]
        }
        
        
      
    }
    
    
    
    
    
}



extension Board_ViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    
    // Cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! Cell_Board_CollectionView
        
        cell.backgroundColor = .white
        cell.board_img.image = UIImage(named: "b3")
        cell.board_label.text = dataArray[indexPath.row]
        
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
        return 1 // 1픽셀 띄우겠다
    }
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // Cell Size (옆 라인을 고려하여 설정)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        let size = CGSize(width: width, height: width)
        return size
    }
    
}
