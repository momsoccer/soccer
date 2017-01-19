//
//  Mission.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 11..
//  Copyright © 2017년 심성보. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Mission: Mappable {
    var missionid: Int?
    var typeid: Int?
    var sequence:Int?
    var missionname: String?
    var description: String?
    var precon: String?
    var fullyoutubeaddr: String?
    var youtubeaddr: String?
    var grade:Int?
    var passgrade:Int?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.missionid <-  map["missionid"]
        self.typeid <-  map["typeid"]
        self.sequence <-  map["sequence"]
        self.missionname <-  map["missionname"]
        self.description <-  map["description"]
        self.precon <-  map["precon"]
        self.fullyoutubeaddr <-  map["fullyoutubeaddr"]
        self.youtubeaddr <-  map["youtubeaddr"]
        self.grade <-  map["grade"]
        self.passgrade <-  map["passgrade"]
    }
}


/*
 "missionid": 170,
 "categoryid": 9,
 "typeid": 16,
 "typename": "DRIBLE",
 "sequence": 27,
 "missionname": "1대1 돌파 헛다리 페인팅",
 "description": "이영표선수가 자주하는 기술 헛다리 페인팅입니다. 인인 아웃사이드 드리블 패턴을 익히셨다면 도전해보세요. 경험치가 140 !!",
 "precon": "헛다리 페인팅 모션이 자연스럽게 구사되면 미션 성공",
 "videoaddr": "https://youtu.be/gjKAxrBMo5o",
 "fullyoutubeaddr": "https://youtu.be/gjKAxrBMo5o",
 "youtubeaddr": "gjKAxrBMo5o",
 "enabled": "Y",
 "feetype": "N",
 "grade": 140,
 "passgrade": 140,
 "creationdate": 1476843583000,
 "updatedate": 1476843583000,
 "change_creationdate": "2016-10-19 11:19:43 AM",
 "change_updatedate": "2016-10-19 11:19:43 AM",
 "opencount": 0,
 "getpoint": 100,
 "escapepoint": 100,
 "uid": 0,
 "uploadcount": 0,
 "missionpasscount": 0,
 "enname": "Preparing an English translation",
 "endescription": "Preparing an English translation",
 "enprecon": "Preparing an English translation",
 "cnname": "中文翻译准备",
 "cndescription": "中文翻译准备",
 "cnprecon": "中文翻译准备"
*/
