//
//  User.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 11..
//  Copyright © 2017년 심성보. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class User: Mappable {
    var uid: Int?
    var username: String?
    var useremail: String?
    var snstype: String?
    var snsid: String?
    var profileimgurl: String?
    var level: Int?
    var totalscore:Int?
    var teamid:Int?
    var teamname:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        uid <- map["uid"]
        username <- map["username"]
        useremail <- map["useremail"]
        snstype <- map["snstype"]
        snsid <- map["snsid"]
        profileimgurl <- map["profileimgurl"]
        level <- map["level"]
        totalscore <- map["totalscore"]
        teamid <- map["teamid"]
        teamname <- map["teamname"]
    }
    
}
