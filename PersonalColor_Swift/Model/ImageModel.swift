//
//  ImageModel.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/24.
//

import Foundation

class ImageModel{
    var seq : Int
    var uid : String
    var imageName : String
    var imagefile : Data //  이미지
    
    init(seq: Int, uid: String, imageName: String, imagefile: Data) {
        self.seq = seq
        self.uid = uid
        self.imageName = imageName
        self.imagefile = imagefile
    }
}
