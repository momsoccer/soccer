//
//  UserStaticInfo.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 13..
//  Copyright © 2017년 심성보. All rights reserved.
//

import Foundation
import UIKit

class UserStaticInfo{
    
    func saveUser(uid:Int,useremail:String,username:String,level:Int,totalscore:Int,teamid:Int,profileimg:String,teamname:String){
        
        let userDefaults = Foundation.UserDefaults.standard
        
        userDefaults.setValue(uid, forKey: "uid")
        userDefaults.setValue(useremail, forKey: "useremail")
        userDefaults.setValue(username, forKey: "username")
        userDefaults.setValue(level, forKey: "level")
        userDefaults.setValue(totalscore, forKey: "totalscore")
        userDefaults.setValue(teamid, forKey: "teamid")
        userDefaults.setValue(profileimg, forKey: "profileimg")
        userDefaults.setValue(teamname, forKey: "teamname")
    }
    
    func deleteDefaults(){
        let userDefaults = Foundation.UserDefaults.standard
        
        userDefaults.removeObject(forKey: "uid")
        userDefaults.removeObject(forKey: "useremail")
        userDefaults.removeObject(forKey: "username")
        userDefaults.removeObject(forKey: "level")
        userDefaults.removeObject(forKey: "totalscore")
        userDefaults.removeObject(forKey: "teamid")
        userDefaults.removeObject(forKey: "teamname")
        userDefaults.removeObject(forKey: "profileimg")
        
        //전체 삭제
        //let appDomain = Bundle.main.bundleIdentifier
        //UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        
        userDefaults.synchronize()
    }
    
    func getKeyInt(key:String) -> Int {
        let userDefaults = Foundation.UserDefaults.standard
        let keyValue:Int = userDefaults.integer(forKey: key)
        return keyValue;
    }
    
    func getKeyString(key:String) -> String {
        let userDefaults = Foundation.UserDefaults.standard
        
        let keyValue = userDefaults.string(forKey: key)
        return keyValue!
    }
    
    
}
