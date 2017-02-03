//
//  FindUserViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 17..
//  Copyright © 2017년 심성보. All rights reserved.
// 레이아웃 상에서 콜렉션 뷰를 마우스 오른쪽으로 view 컨트롤러에 딜리케이트 연결

import UIKit
import Alamofire
import NVActivityIndicatorView
import AlamofireObjectMapper
import ObjectMapper
import Kingfisher


class FindUserViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,NVActivityIndicatorViewable {
    
    @IBOutlet weak var findItem: UITextField!
    @IBOutlet weak var seletedItem: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var refreshControl:UIRefreshControl!
    
    var page:Int = 1;
    var inputOffset:Int = 0;
    let limitNumber:Int = 40;
    
    let serverUrl = WebAddr();
    
    lazy var uList : [User] = {
        var datalist = [User]()
        return datalist
    }()
    
    lazy var insList : [Instructor] = {
        var dataList = [Instructor]()
        return dataList
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.tintColor = UIColor.red
        self.refreshControl.addTarget(self, action: #selector(FindUserViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refreshControl)
        
        //명시를 하지 않으면 혼란이 생길 수 있기에...
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //유저 정보 가져오기
        callUserAPI(searchName: self.findItem.text!, limitNum: self.limitNumber, offset: self.inputOffset)
        
        //강사 레이아웃 셀 뷰 ... 미리 로딩해놓기
        self.collectionView.register(UINib(nibName: "InsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InsCell")
        
        //강사 정보를 우선 가져온다.
        print("강사정보를 갖고 있음..")
        callUserAPI(searchName: self.findItem.text!, limitNum: limitNumber, offset: 0,queryType:1)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.perform(#selector(self.endRefresh), with: nil, afterDelay: 1.0)
    }
    
    func endRefresh() {
        self.inputOffset = 0
        callUserAPI(searchName: self.findItem.text!, limitNum: self.limitNumber, offset: self.inputOffset)
        refreshControl?.endRefreshing()
    }
    
    
    @IBAction func findAction(_ sender: Any) {
        self.page = 0
        callUserAPI(searchName: self.findItem.text!, limitNum: limitNumber, offset: 0,queryType: self.seletedItem.selectedSegmentIndex)
    }
    
    @IBAction func selectedItemAction(_ sender: Any) {
        self.page = 0
        self.collectionView.reloadData()
    }
    
    @IBAction func textDismiss(_ sender: Any) {
        findItem.resignFirstResponder()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(self.seletedItem.selectedSegmentIndex==0){
            return self.uList.count
        }else{
            return self.insList.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.seletedItem.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FindCollectionViewCell
            
            let row = self.uList[indexPath.row]
            
            cell.name.text = row.username
            cell.level.text = "\(row.level!)"
            
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
            
            //마지막 로우 -1 이라면 실행
            if indexPath.row == self.uList.count - 2 {
                self.page += 1;
                self.inputOffset = limitNumber * page;
                callUserAPI(searchName: self.findItem.text!, limitNum: self.limitNumber, offset: self.inputOffset)
            }
            
            return cell
            
        }else {
            //강사탭 일 경우
            
            //self.collectionView.register(UINib(nibName: "InsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InsCell")
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsCell", for: indexPath) as! InsCollectionViewCell
            
            let row = self.insList[indexPath.row]
            
            //print("TeamName :\(row.teamname)")
            
            cell.insName.text = row.name
            cell.insteamname.text = row.teamname
            
            DispatchQueue.main.async(execute: {
                
                if  row.profileimgurl != nil {
                    let imageUrl:String? = row.profileimgurl
                    
                    if((imageUrl?.characters.count)! > 7){
                        
                        let url = URL(string: imageUrl!)
                        cell.insImage.kf.setImage(with: url!,
                                                   placeholder: UIImage(named: "user_horder.png"))
                    }
                }
            })
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let page = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController;
        page.onDedPAge = "seachFind";
        self.present(page, animated: true, completion: nil)
    }
    
    @IBAction func FindReturned(val: UIStoryboardSegue){
        
    }
    
    func callUserAPI(searchName:String = "", limitNum:Int = 40, offset:Int = 0,queryType:Int = 0){
        
        //스피너 정의
        let size = CGSize(width: 50, height:50)
        self.startAnimating(size, message: NSLocalizedString("Server_and_Network", comment: "정보를 가져옵니다"), type: NVActivityIndicatorType(rawValue: 22)!)
        
        let apiUrl = serverUrl.serverAddr + "api/user/getusersearchlist"

        
        if queryType == 0 {
            
            let parameters: Parameters = [
                "username": searchName,
                "limit": limitNum,
                "offset": offset
            ]
            
            //유저 조회 일때
            Alamofire.request(apiUrl,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default
                ).responseArray { (response: DataResponse<[User]>) in
                    
                    if response.result.error == nil {
                        
                        let users = response.result.value;
                        
                        //print("가져온 카운터는 : \(users?.count)")
                        
                        if offset == 0 {
                            self.uList = users!
                            self.stopAnimating()
                            self.collectionView.reloadData()
                        }else{
                            self.uList.append(contentsOf: users!)
                            self.stopAnimating()
                            self.collectionView.reloadData()
                        }
                        
                    }else{
                        print("통신에 문제가 있습니다")
                        self.stopAnimating()
                    }
            }
        }else{
            //강사 조회 일때....
            let apiUrl = serverUrl.serverAddr + "/api/ins/getCoachSearchList"
            
            let parameters: Parameters = [
                "name": searchName,
                "limit": limitNum,
                "offset": offset
            ]
            
            Alamofire.request(apiUrl,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default
                ).responseArray { (response: DataResponse<[Instructor]>) in
                    
                    if response.result.error == nil {
                        
                        let insUser = response.result.value;
                    
                        if offset == 0 {
                            self.insList = insUser!
                            self.stopAnimating()
                            self.collectionView.reloadData()
                        }else{
                            self.insList.append(contentsOf: insUser!)
                            self.stopAnimating()
                            self.collectionView.reloadData()
                        }
                        
                    }else{
                        print("통신에 문제가 있습니다")
                        self.stopAnimating()
                    }
            }
            
            self.collectionView.reloadData()
            self.stopAnimating()
        }
    }
    
    //이미지 메모라이제이션
    func getThumbnailImage(_ index:Int) -> UIImage {
        
        let user = self.uList[index]
        
        if let savedImage = user.thumbnailImage{
            return savedImage
        }else{
            
            /*
             let url: URL! = URL(string: mvo.thumbnail!)
             let imageData = try! Data(contentsOf: url)
             user.thumbnailImage = UIImage(data: imageData)
             */
            return user.thumbnailImage!
        }
        
    }
    
    
}
