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
    
    // db데이터 가져온리스트
    var colorList : [ColorQuery] = []
    var redValue : Int = 0
    var greenValue : Int = 0
    var blueValue : Int = 0
    
    
    
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
        selectAction()
    }

 

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // selectAction
    func selectAction(){
        colorList.removeAll()
        let queryModel = ColorSelect()
        // extension 과 protocol이 연결
        queryModel.delegate = self
        // 데이터 가져와서 화면 구성
        queryModel.downloadItems(id: UserDefaults.standard.string(forKey: "id")!)
    }
    
    
}//ColorViewController


extension ColorViewController : ColorModelProtocol{
    func itemDownloaded(items : [ColorQuery]) {
        self.colorList = items
        lblRed.text = String(colorList[0].red)
        lblGreen.text = String(colorList[0].green)
        lblBlue.text = String(colorList[0].blue)
        
        imgView.backgroundColor = UIColor(red: CGFloat(colorList[0].red) / 255.0, green: CGFloat(colorList[0].green) / 255.0, blue: CGFloat(colorList[0].blue) / 255.0, alpha: 1.0)

        redValue=colorList[0].red
        greenValue=colorList[0].green
        blueValue=colorList[0].blue
        
    }
}

