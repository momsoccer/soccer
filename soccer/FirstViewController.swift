//
//  FirstViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 12..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import NVActivityIndicatorView
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class FirstViewController: UIViewController,GIDSignInDelegate, GIDSignInUIDelegate,NVActivityIndicatorViewable{
    
    var window: UIWindow?
    
    var uid:Int? = 0
    var snstype:String?
    var snsid:String?
    var useremail:String?
    var username:String? = ""
    var profileimgurl:String?
    var level:Int? = 0
    var totalscore:Int? = 0
    var teamid:Int? = 0
    var teamname:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("========== first view Controller ==========")
        
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        
        if error != nil {
            print("에러입니다")
        }
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            print("로그인 상태입니다")
            //로그인 상태라면 유저 정보를 가져온다
            GIDSignIn.sharedInstance().signInSilently();
            
            
        }else{
            print("로그아웃 상태입니다")
            //초기화
            let userDefault = UserStaticInfo();
            userDefault.deleteDefaults()
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        print("========== 구글 로그인 메서드 호출 후 ==========")
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            
            
            self.snstype = "google";
            self.snsid = user.userID;
            self.useremail = user.profile.email;
            self.username = user.profile.name;
            self.profileimgurl = user.profile.imageURL(withDimension: 100).description
            
            //유저가 서버에 등록되어 있는지 체크
            let size = CGSize(width: 50, height:50)
            startAnimating(size, message: "서버와 통신 중입니다", type: NVActivityIndicatorType(rawValue: 22)!)
            
            let serverUrl = WebAddr();
            let getUrl = serverUrl.serverAddr+"all/existuser"
            
            let parameters: Parameters = ["snstype" : snstype!  //느낌이가 없으면 옵셔날 문자가 보내짐..
                ,"snsid"     : snsid!
                ,"password"  : "0000000"
                ,"useremail" : useremail!
            ];
            
            Alamofire.request(getUrl,parameters:parameters).responseObject { (response: DataResponse<User>) in
                if(response.result.isSuccess){
                    
                    let userinfo = response.result.value
                    
                    let suid = userinfo?.uid;
                    self.uid = Int(suid!);
                    
                    //유저가 없기 때문에 회원 가입을 시킨다
                    if(self.uid == 0){
                        print("유저를 가입 시킵니다")
                        let serverUrl = WebAddr();
                        let getUrl = serverUrl.serverAddr+"all/insert"
                        let parameters: Parameters = [
                            "username": self.username!
                            ,"useremail":self.useremail!
                            ,"snstype": "google"
                            ,"snsid": self.snsid!
                            ,"password":self.snsid!
                            ,"profileimgurl" : self.profileimgurl!
                            ,"googleemail" : self.useremail!
                        ]
                        
                        Alamofire.request(getUrl
                            ,method: .post
                            ,parameters: parameters
                            ,encoding: JSONEncoding.default).responseObject { (response: DataResponse<ServerResult>) in
                                
                                switch response.result {
                                case .success:
                                    
                                    let serverResult = response.result.value
                                    let tuid = serverResult?.count;
                                    self.uid = Int(tuid!)
                                    
                                    print("회원이 되셨습니다")
                                    print("Validation Successful Uid : \(serverResult?.count)")
                                    
                                case .failure(let error):
                                    print("에러코드는 \(error)")
                                    return;
                                }
                        }
                    }else{
                        print("이미 회원 이십니다!")
                        
                        self.level = userinfo?.level!
                        self.totalscore = userinfo?.totalscore!
                        self.teamid = userinfo?.teamid!
                        
                        //Why error?
                        /*
                        if userinfo?.teamname! != nil {
                            print("\(userinfo?.teamname!)")
                            //self.teamname = userinfo?.teamname!
                        }else{
                            print("모지모지")
                        }
                         */
 
                        
                     }
                
                    //Save userDefault
                    let userDefaults = UserStaticInfo();
                    userDefaults.saveUser(uid: self.uid!,
                                          useremail: self.useremail!,
                                          username: self.username!,
                                          level: self.level!,
                                          totalscore: self.totalscore!,
                                          teamid: self.teamid!,
                                          profileimg: self.profileimgurl!,
                                          teamname: self.teamname!
                    )
                    
                }else{
                    print("에러입니다 \(response.result.error)")
                }
                
                self.stopAnimating()
                
                
                self.startAppInit()
                let firstView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController;
                self.present(firstView, animated: true, completion: nil)
            }
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("Google login \(error.localizedDescription)")
        }else{
            print("it's user logining")
        }
        
    }
    
    
    //회원 및 회원 가입 후 리스타트
    func startAppInit(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let firstStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = firstStoryboard.instantiateViewController(withIdentifier: "TabBarView") // TabBarView / MenuView / ViewController
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn();
    }
    

    
    
}
