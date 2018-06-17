//
//  SpeechVO.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation


struct SpeechVO: Codable {
    var result: Int?
    var meta: SpeechMeta?
}


struct SpeechMeta:Codable{
    
    var Category:String?
    var response: [SpeechResponse]?
    
    
    
}
struct SpeechResponse:Codable{
    
    var code: String?
    var name: String?
    var height: Int?
    var address: String?
    var management: String?
    var detail: String?
    var summary: String?
    var imageURL:String?
    var isFamous: Int?
    
}
