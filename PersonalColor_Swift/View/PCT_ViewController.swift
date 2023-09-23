//
//  PCT_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 강대규 on 2023/09/23.
//

import UIKit

class PCT_ViewController: UIViewController {
    

    @IBOutlet weak var lblType: UILabel!
    var pcType : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(pcType)
        lblType.text = pcType
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
