//
//  UserMainVo.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 24..
//  Copyright © 2017년 심성보. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class UserMainVo: Mappable {
    
    var uid:Int?
    var instructorid:Int?
    var missionid:Int?
    var usermissionid:Int?
    var username:String?
    var insname:String?
    var teamname:String?
    var profileimgurl:String?
    
    var missiontype:String?
    var missionname:String?
    var description:String?
    var uservideo:String?
    var missionvideo:String?
    var grade:Int?
    var passgrade:Int?
    var sequence:Int?
    var bookmarkcount:Int?
    var passflag:String?
    var missionpasscount:Int?
    var feedbackcount:Int?
    var boardcount:Int?
    var totalscore:Int?
    var teamid:Int?
    var level:Int?
    var usersubject:String?
    var userdescription:String?
    var condition:String?
    var change_creationdate:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        uid <- map["uid"]
        instructorid <- map["instructorid"]
        missionid <- map["missionid"]
        usermissionid <- map["usermissionid"]
        username <- map["username"]
        insname <- map["insname"]
        teamname <- map["teamname"]
        profileimgurl <- map["profileimgurl"]
        
        missiontype <- map["missiontype"]
        missionname <- map["missionname"]
        description <- map["description"]
        uservideo <- map["uservideo"]
        missionvideo <- map["missionvideo"]
       
        grade <- map["grade"]
        passgrade <- map["passgrade"]
        sequence <- map["sequence"]
        bookmarkcount <- map["bookmarkcount"]
        passflag <- map["passflag"]
        
        missionpasscount <- map["missionpasscount"]
        feedbackcount <- map["feedbackcount"]
        boardcount <- map["boardcount"]
        totalscore <- map["totalscore"]
        teamid <- map["teamid"]
        level <- map["level"]
        
        usersubject <- map["usersubject"]
        userdescription <- map["userdescription"]
        condition <- map["condition"]
        change_creationdate <- map["change_creationdate"]
    }

}
/*
 private int uid;
 private int instructorid;
 private int missionid;
 private int usermissionid;
 private String username;
 private String insname;
 private String teamname;
 private String profileimgurl;
 
 private String missiontype;
 private String missionname;
 private String description;
 private String uservideo;
 private String missionvideo;
 private int grade;
 private int passgrade;
 private int sequence;
 private int bookmarkcount;
 private String passflag;
 
 private int missionpasscount;
 private int feedbackcount;
 private int boardcount;
 private int totalscore;
 private int teamid;
 private int level;
 
 private String change_creationdate;
 
 private String usersubject;
 private String userdescription;
 private String condition;
 
 //pageing
 private int limit;
 private int offset;
 
 private String friendcheck;
 private String teamcheck;
 private String passyescheck;
 private String passnocheck;
 
 private String cnname;
 private String cndescription;
 private String cnprecon;
 
 private String enname;
 private String endescription;
 private String enprecon;
 
 //in 조회 조건을 위한....
 private List<String> typename;
 private int listCount;
 */
