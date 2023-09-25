//
//  Detail_Board_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/22.
//

import UIKit

class Detail_Board_ViewController: UIViewController {

    var name = ""
    @IBOutlet var lbl: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbl.text = name
        // Do any additional setup after loading the view.
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
