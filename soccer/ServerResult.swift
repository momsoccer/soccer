import Foundation
import AlamofireObjectMapper
import ObjectMapper

class ServerResult: Mappable {

    var count: Int?
    var result:String?
    var errorMSg:String?
    var getid:Int?;
    var avg:Float?;
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.count <-  map["count"]
        self.result <-  map["result"]
        self.errorMSg <-  map["errorMSg"]
        self.getid <-  map["getid"]
        self.avg <-  map["avg"]
    }
}
