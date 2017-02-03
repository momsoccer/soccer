//
//  RankingTableViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 17..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import AlamofireObjectMapper
import ObjectMapper
import Kingfisher

class RankingTableViewController: UITableViewController,NVActivityIndicatorViewable {
    
    var page:Int = 1;
    var inputOffset:Int = 0;
    let limitNumber:Int = 40;
    
    let serverUrl = WebAddr();
    
    lazy var  userMissionList : [UserMainVo] = {
        var datalist = [UserMainVo]()
        return datalist
    }()
    
    var typename = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl?.attributedTitle = NSAttributedString(string: "데이터 갱신")
        refreshControl?.tintColor = UIColor.red
        
        refreshControl?.addTarget(self,
                                  action: #selector(RankingTableViewController.handleRefresh(refreshControl:)),
                                  for: UIControlEvents.valueChanged)
        
        //데이터 가져오기
        callUserMissionVideoAPI()
    }

    
    func handleRefresh(refreshControl: UIRefreshControl) {
        //1초의 딜레이를 준다..
        self.perform(#selector(self.endRefresh), with: nil, afterDelay: 1.0)
    }
    
    func endRefresh() {
        print("새로고침을 합니다")
        callUserMissionVideoAPI()
        refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userMissionList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RankingCell", for: indexPath) as! RankingTableViewCell
        
        let row = self.userMissionList[indexPath.row]
        
        print("유저 이름은 : \(row.username)")
        
        
        cell.name.text = row.username
        
        //유저이미지
        DispatchQueue.main.async(execute: {
            
            if  row.profileimgurl != nil {
                let imageUrl:String? = row.profileimgurl
                
                if((imageUrl?.characters.count)! > 7){
                    
                    let url = URL(string: imageUrl!)
                    cell.userImage.kf.setImage(with: url!,
                                               placeholder: UIImage(named: "user_horder.png"))
                }
            }
        })
        
        //비디오 이미지
        DispatchQueue.main.async(execute: {
            
            if  row.profileimgurl != nil {
                let videoImagUrl:String? = row.uservideo
                let urladdr:String? = "https://img.youtube.com/vi/\(videoImagUrl!)/mqdefault.jpg"
                
                if((videoImagUrl?.characters.count)! > 7){
                    
                    let url = URL(string: urladdr!)
                    cell.missionVideoImage.kf.setImage(with: url!,
                                               placeholder: UIImage(named: "video_holder.png"))
                }
            }
        })
 
        return cell
    }
    
    func callUserMissionVideoAPI(offsetNumber:Int = 0){
        
        //스피너 정의
        let size = CGSize(width: 50, height:50)
        self.startAnimating(size, message: NSLocalizedString("Server_and_Network", comment: "정보를 가져옵니다"), type: NVActivityIndicatorType(rawValue: 22)!)
        
        let apiUrl = serverUrl.serverAddr + "/api/usermain/getUserMainList"

        self.typename = ["DRIBLE","TRAPING","LIFTING","AROUND","COMPLEX","FLICK"];
        
            let parameters: Parameters = [
                //"missiontype": nil as! Any,
                //"missionname": nil as! Any,
                "offset": offsetNumber,
                "limit": self.limitNumber,
                //미션주제별 조건 Array
                "typename" : self.typename,
                "listCount" : self.typename.count
            ]
            
            //유저 조회 일때
            Alamofire.request(apiUrl,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default
                ).responseArray { (response: DataResponse<[UserMainVo]>) in
                    
                    if response.result.error == nil {
                        
                        let list = response.result.value;
                        
                        print("가져온 카운터는 !! : \(list?.count)")
                        
                        if offsetNumber == 0 {
                            self.userMissionList = list!
                            self.stopAnimating()
                            self.tableView.reloadData()
                        }else{
                            self.userMissionList.append(contentsOf: list!)
                            self.stopAnimating()
                            self.tableView.reloadData()
                        }
                        
                    }else{
                        print("통신에 문제가 있습니다")
                        self.stopAnimating()
                    }
            }
    }


}
