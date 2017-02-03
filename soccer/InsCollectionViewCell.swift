//
//  InsCollectionViewCell.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 24..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit

class InsCollectionViewCell: UICollectionViewCell {

    //연결이 오너 파일로 되면 에러임...주의
    @IBOutlet weak var insteamname: UILabel!
    @IBOutlet weak var insImage: UIImageView!
    @IBOutlet weak var insName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
