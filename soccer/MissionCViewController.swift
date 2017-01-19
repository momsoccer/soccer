//
//  MissionCViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 9..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import expanding_collection
import NVActivityIndicatorView
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Kingfisher

class MissionCViewController: ExpandingViewController,NVActivityIndicatorViewable {
    
    var nameLabel:String?
    @IBOutlet weak var missionNameLabel: UILabel!
    
    var seedMission:[Mission]? = Array<Mission>();
    var missionObject:Mission?;
    
    fileprivate var cellsIsOpen = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        missionNameLabel.text = nameLabel
        registerCell()
        
        let serverUrl = WebAddr();
        let getUrl = serverUrl.serverAddr+"api/mission/getMissionList"
        
        let parameters: Parameters = ["typename": self.nameLabel!,"uid":0];
        
        let size = CGSize(width: 50, height:50)
        startAnimating(size, message: "서버와 통신 중입니다", type: NVActivityIndicatorType(rawValue: 22)!)
        
        Alamofire.request(getUrl,parameters: parameters).responseArray { (response: DataResponse<[Mission]>) in
            
            if response.result.error == nil {
                
                let missions = response.result.value;
                //print("미션 데이터를 가져 옵니다")
                
                //자바 순서랑 틀린거 같다. 순서를 바꾸어 준다...반대로
                let missionsList = missions?.sorted{$0.sequence! < $1.sequence!}
                
                self.seedMission = missionsList
                
                self.collectionView?.reloadData()
                self.stopAnimating()
                
            }else{
                print("통신에 문제가 있습니다")
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func returned(segue: UIStoryboardSegue){
        
    }
}

// MARK: Helpers
extension MissionCViewController {
    
    fileprivate func registerCell() {
        let nib = UINib(nibName: String(describing: MissionCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: MissionCollectionViewCell.self))
    }
    
    fileprivate func fillCellIsOpeenArry() {
        for _ in self.seedMission! {
            cellsIsOpen.append(false)
        }
    }
    
    
    fileprivate func getViewController() -> VideoViewController {
        //let storyboard = UIStoryboard(storyboard: .Main)
        let videoView = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "VideoMission") as! VideoViewController;
        
        return videoView
    }
 
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
}

// MARK: UIScrollViewDelegate
extension MissionCViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //pageLabel.text = "\(currentIndex+1)/\(items.count)"
    }
}

extension MissionCViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        
        guard let cell = cell as? MissionCollectionViewCell else { return }
        
        let row = indexPath.row
        
        let level = self.seedMission![row].sequence
        cell.nameLabel.text = self.seedMission![row].missionname
        cell.descriptionLabel.text = self.seedMission![row].description
        cell.levelLabel.text = "레벨: \(level!)"
        
        var imageUrl:String? = self.seedMission![row].youtubeaddr
        let urladdr:String? = "https://img.youtube.com/vi/\(imageUrl!)/mqdefault.jpg"
    
        let url = URL(string: urladdr!)
        cell.missionImage.kf.setImage(with: url!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        
        guard let _ = collectionView.cellForItem(at: indexPath) as? MissionCollectionViewCell
            , currentIndex == (indexPath as NSIndexPath).row else { return }
        
        let row = indexPath.row
        
        missionObject = self.seedMission![row]
        
        let videoView = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "VideoMission") as! VideoViewController;
        videoView.videoMission = missionObject;
        self.present(videoView, animated: true, completion: nil)
        
    }
 
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.seedMission!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MissionCollectionViewCell.self), for: indexPath)
    }
}

