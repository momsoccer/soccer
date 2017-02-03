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
        
        //아래 펀션으로 따로 빼서 리프레쉬 기능 적용?
        
        let serverUrl = WebAddr();
        let getUrl = serverUrl.serverAddr+"api/mission/getMissionList"
        
        let parameters: Parameters = ["typename": self.nameLabel!,"uid":0];
        
        let size = CGSize(width: 50, height:50)
        startAnimating(size, message: NSLocalizedString("Server_and_Network", comment: "서버통신"), type: NVActivityIndicatorType(rawValue: 22)!)
        
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
    
    @IBAction func missionCreturned(segue: UIStoryboardSegue){
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
        
        let imageUrl:String? = self.seedMission![row].youtubeaddr
        let urladdr:String? = "https://img.youtube.com/vi/\(imageUrl!)/mqdefault.jpg"
    
        let url = URL(string: urladdr!)
        cell.missionImage.kf.setImage(with: url!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        
        
        print("선택 \(indexPath.row)")
        
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
    
    //빽 버튼
    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("test ========================")
        
        
        if segue.identifier == "videoview"{
            
            //첫 번째 인자값을 이용하여 사용자가 몇 번째 행을 선택했는지 확인 한다
            let path = self.collectionView?.indexPath(for: sender as! MissionCollectionViewCell)
            
            //행 정보를 통해 선택된 용화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다
            let detailVC = segue.destination as? VideoViewController
            detailVC?.videoMission = self.seedMission?[path!.row]
        }
    }
     */
    
}

