//
//  RecommendViewController.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/24.
//

import UIKit

class RecommendViewController: UIViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblPC: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgView.image = UIImage(named: "winterRecommend.png")
        lblPC.text = "Winter Cool"
    }
    


    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
