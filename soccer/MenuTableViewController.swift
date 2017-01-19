//
//  MenuTableViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 11..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import Kingfisher

class MenuTableViewController: UITableViewController, GIDSignInDelegate {

    var window: UIWindow?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
        
        let userDefault = UserStaticInfo()
        
        userEmail.text = userDefault.getKeyString(key: "useremail")
        userName.text = userDefault.getKeyString(key: "username")
        
        //이미지 매핑
        let imageUrl:String? = userDefault.getKeyString(key: "profileimg")
        let url = URL(string: imageUrl!)
        userImage.kf.setImage(with: url)
 
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        
        if error != nil {
            print("에러입니다")
        }
        
        GIDSignIn.sharedInstance().delegate = self
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            print("로그인 상태입니다")
            //로그인 상태라면 유저 정보를 가져온다
            GIDSignIn.sharedInstance().signInSilently();
            
            
        }else{
            print("로그아웃 상태입니다")
        }
    }

    
    @IBAction func logOut(_ sender: Any) {

        print("===== 로그아웃 합니다 =====")
        
        GIDSignIn.sharedInstance().signOut();
        GIDSignIn.sharedInstance().disconnect();
    
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        print("===== 로그아웃 후 수행할 기능들")

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let firstStoryboard = UIStoryboard(name: "First", bundle: nil)
        let viewController = firstStoryboard.instantiateViewController(withIdentifier: "First") // TabBarView / MenuView / ViewController
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        //let firstView = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "First") as! FirstViewController;
        //self.present(firstView, animated: true, completion: nil)
 
        print("리스타트 합니다.")
    }

}
