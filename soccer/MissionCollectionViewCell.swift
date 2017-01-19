//
//  MissionCollectionViewCell.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 9..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import expanding_collection

class MissionCollectionViewCell: BasePageCollectionCell {

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var missionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
