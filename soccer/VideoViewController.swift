//
//  VideoViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 12..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoViewController: UIViewController {

    var videoMission:Mission?;
    @IBOutlet weak var playerView: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("전 화면에서 데이터를 가져왔습니다")
        print("로그 : \(videoMission?.description)")
        
        let videoAddr:String? = videoMission!.youtubeaddr;
        
        playerView.playerVars = [
            "playsinline": "1" as! AnyObject,
            "controls": "0" as! AnyObject,
            "showinfo": "0" as! AnyObject
        ]
        
        playerView.loadVideoID(videoAddr!)
        
        
        
    }
    
    @IBAction func returned(val: UIStoryboardSegue){
        print("돌아왔습니다")
    }
    
    

}
