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
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tvContent: UITextView!
    
    
    @IBOutlet var img: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = title_text
        tvContent.text = content_text
        //id = UserDefaults.standard.string(forKey: "id")!
        // 이미지주소 data로 바꾸기
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
