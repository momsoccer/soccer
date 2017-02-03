//
//  ViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 5..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import NVActivityIndicatorView
import ENSwiftSideMenu

class ViewController: UIViewController, NVActivityIndicatorViewable, ENSideMenuDelegate{
    
    @IBOutlet weak var dribbleImage: UIImageView!
    @IBOutlet weak var trapping: UIImageView!
    @IBOutlet weak var liftting: UIImageView!
    @IBOutlet weak var arround: UIImageView!
    @IBOutlet weak var flick: UIImageView!
    @IBOutlet weak var crossbar: UIImageView!
    
    
    var missionToken:String?
    var curMission = Array<Mission>();
    
    
    @IBAction func toggleSideMenu(_ sender: Any) {
        toggleSideMenuView()
    }
    
    //뷰가 시작될때 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("viewDidLoad()")
        
        sideMenuController()?.sideMenu?.delegate = self
        self.view.backgroundColor = MomClolor.hexStringToUIColor(hex: MomClolor.mom_color1)
        
        
        //이미지에 대한 버튼 등록
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapGesture1))
        dribbleImage.addGestureRecognizer(tap1)
        dribbleImage.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapGesture2))
        trapping.addGestureRecognizer(tap2)
        trapping.isUserInteractionEnabled = true
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapGesture3))
        liftting.addGestureRecognizer(tap3)
        liftting.isUserInteractionEnabled = true
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(tapGesture4))
        arround.addGestureRecognizer(tap4)
        arround.isUserInteractionEnabled = true
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(tapGesture5))
        flick.addGestureRecognizer(tap5)
        flick.isUserInteractionEnabled = true
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(tapGesture6))
        crossbar.addGestureRecognizer(tap6)
        crossbar.isUserInteractionEnabled = true
    }
    
    func tapGesture1() {
        goMissionPage(missionPage:"DRIBLE");
    }
    
    func tapGesture2() {
        goMissionPage(missionPage:"TRAPING");
    }
    
    func tapGesture3() {
        goMissionPage(missionPage:"LIFTING");
    }
    
    func tapGesture4() {
        goMissionPage(missionPage:"AROUND");
    }
    
    func tapGesture5() {
        goMissionPage(missionPage:"FLICK");
    }
    
    func tapGesture6() {
        goMissionPage(missionPage:"COMPLEX");
    }
    
    
    
    
    
    //뷰가 그려지기 직전 2
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print("viewWillAppear()")
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //뷰가 끝날때 3
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //print("viewWillDisappear()")
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func sideMenuWillOpen() {
        self.setTabBarVisible(visible: false, animated: true) //하단 탭바를 숨긴다
        //self.viewWillDisappear(true)
    }
    
    func sideMenuWillClose() {
        self.setTabBarVisible(visible: true, animated: true) //하단 탭바를 보이게 한다
        //self.viewWillAppear(true)
    }
    
    
    @IBAction func mainReturned(val: UIStoryboardSegue){
        //scene end
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //logout execute code
    }
    
    //Move MissionPage
    func goMissionPage(missionPage:String){
        
        let page = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "missionview") as! MissionCViewController;
        page.nameLabel = missionPage;
        self.present(page, animated: true, completion: nil)
        
    }
    
}


extension ViewController {
    
    func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (isTabBarVisible == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
}


extension ViewController {
    //add code
    
}



