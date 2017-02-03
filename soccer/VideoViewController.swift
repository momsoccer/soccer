//
//  VideoViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 12..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoViewController: UIViewController, YouTubePlayerDelegate {

    var videoMission:Mission?;
    @IBOutlet weak var playerView: YouTubePlayerView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinner.startAnimating()
        
        self.playerView.delegate = self
        let videoAddr:String? = videoMission!.youtubeaddr;
        
        playerView.playerVars = [
            "playsinline": "1" as AnyObject,
            "controls": "0" as AnyObject,
            "showinfo": "0" as AnyObject
        ]
        
        playerView.loadVideoID(videoAddr!)
    }
    
    @IBAction func videoBackreturned(val: UIStoryboardSegue){
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.spinner.stopAnimating()
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
    }
    
}
