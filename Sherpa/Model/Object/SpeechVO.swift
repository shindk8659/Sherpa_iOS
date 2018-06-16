//
//  SpeechVO.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import ObjectMapper

class SpeechVO: Mappable {
    var result: Double?
    var meta: SpeechMeta?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        meta <- map["meta"]
    }
}
class SpeechMeta:Mappable{
    
    var Category:String?
    var response: [SpeechResponse]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Category <- map["Category"]
        response <- map["response"]
    }
    
    
}
class SpeechResponse:Mappable{
    
    var code: String?
    var name: String?
    var height: Int?
    var address: String?
    var management: String?
    var detail: String?
    var summary: String?
    var imageURL:String?
    var isFamous: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
         code <- map["code"]
         name <- map["name"]
         height <- map["height"]
         address <- map["address"]
         management <- map["management"]
         detail <- map["detail"]
         summary <- map["summary"]
         imageURL <- map["imageURL"]
         isFamous <- map["isFamous"]
        
        
    }
    
    
}
