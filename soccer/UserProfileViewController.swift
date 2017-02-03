//
//  UserProfileViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 20..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var scrollview: UIScrollView!

    @IBOutlet weak var backBtn: UIButton!
    var onDedPAge:String?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.onDedPAge == nil {
            backBtn.isHidden = true
        }else{
            backBtn.isHidden = false
        }
        
        
        
    }
    
    //다른 유저를 검색시
    @IBAction func backPage(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
