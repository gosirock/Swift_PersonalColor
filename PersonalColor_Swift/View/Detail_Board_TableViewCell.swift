//
//  Detail_Board_TableViewCell.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/26.
//

import UIKit

class Detail_Board_TableViewCell: UITableViewCell {

    
    
    @IBOutlet var lblText: UILabel!
    
    
    @IBOutlet var lbltime: UILabel!
    
    @IBOutlet var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        // Configure the view for the selected state
    }

}



