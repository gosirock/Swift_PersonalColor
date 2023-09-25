//
//  ColorViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/24.
//

import UIKit

class ColorViewController: UIViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblRed: UILabel!
    @IBOutlet weak var lblGreen: UILabel!
    @IBOutlet weak var lblBlue: UILabel!
    
    @IBOutlet weak var redImage: UIImageView!
    @IBOutlet weak var greenImage: UIImageView!
    @IBOutlet weak var blueImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 원형이미지뷰
        imgView.layer.cornerRadius = imgView.frame.width / 2 // 정사각형 모양으로 만들기 위해 높이 대신 너비 사용
        imgView.layer.borderWidth = 2
        imgView.clipsToBounds = true
        imgView.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
        
        
        redImage.layer.cornerRadius = redImage.frame.width / 2 // 정사각형 모양으로 만들기 위해 높이 대신 너비 사용
        redImage.layer.borderWidth = 2
        redImage.clipsToBounds = true
        redImage.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
        redImage.backgroundColor = UIColor(red: 255.0 / 255.0, green: 0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        
        greenImage.layer.cornerRadius = greenImage.frame.width / 2 // 정사각형 모양으로 만들기 위해 높이 대신 너비 사용
        greenImage.layer.borderWidth = 2
        greenImage.clipsToBounds = true
        greenImage.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
        greenImage.backgroundColor = UIColor(red: 0 / 255.0, green: 255.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        
        blueImage.layer.cornerRadius = blueImage.frame.width / 2 // 정사각형 모양으로 만들기 위해 높이 대신 너비 사용
        blueImage.layer.borderWidth = 2
        blueImage.clipsToBounds = true
        blueImage.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
        blueImage.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imgView.backgroundColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1.0)
    }

 

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
