//
//  PCT_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 강대규 on 2023/09/25.
//

import UIKit

class PCT_ViewController: UIViewController {
    
    // 이전 페이지에서 받아온 퍼스널컬러값
    var name = ""
    
    // 사진 등록
    var images = [ "spring.png", "summer.png", "fall.png","winter.png"]

    // 퍼스널 컬러 이미지
    @IBOutlet weak var personalColorImg: UIImageView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personalColor(name)
        backgroundSetting ()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func viewBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 이미지 설정
    func personalColor(_ pctype: String){
        print(pctype)
        switch pctype{
        case "봄웜톤":
            self.personalColorImg.image = UIImage(named: images[0])
        case "여름쿨톤":
            self.personalColorImg.image = UIImage(named: images[1])
        case "가을웜톤":
            self.personalColorImg.image = UIImage(named: images[2])
        default:
            self.personalColorImg.image = UIImage(named: images[3])
        }
    }
    
    // 백그라운드 설정
    func backgroundSetting () {
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.view.isOpaque = true
       // modalview.setViewShadow (backView: modalview, colorName: "000", width: -4, height:5)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
