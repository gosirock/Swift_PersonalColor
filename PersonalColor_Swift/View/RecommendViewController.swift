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
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let message = ColorMessage.self
        
        switch message.color{
        case 0: lblPC.text = "Spring Warm"
            imgView.image = UIImage(named: "spring.png")
        case 1: lblPC.text = "Summer Cool"
            imgView.image = UIImage(named: "summer.png")
        case 2: lblPC.text = "Fall Warm"
            imgView.image = UIImage(named: "fall.png")
        default: lblPC.text = "Winter Cool"
            imgView.image = UIImage(named: "winter.png")
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
