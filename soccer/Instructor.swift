//
//  Instructor.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 24..
//  Copyright © 2017년 심성보. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Instructor: Mappable {
    
    var instructorid: Int?
    var email: String?
    var password: String?
    var name: String?
    var profileimgurl: String?
    var profile: String?
    var description: String?
    var teamname: String?
    var teamid: Int?
    var emblem: String?
    var membercount: Int?
    var phone:String?
    var totalscore: Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        instructorid <- map["instructorid"]
        email <- map["email"]
        password <- map["password"]
        name <- map["name"]
        profileimgurl <- map["profileimgurl"]
        profile <- map["profile"]
        description <- map["description"]
        teamname <- map["teamname"]
        teamid <- map["teamid"]
        emblem <- map["emblem"]
        membercount <- map["membercount"]
        phone <- map["phone"]
        totalscore <- map["totalscore"]
    }
    
}
