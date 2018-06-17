//
//  Mountain.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

struct Mountain: Codable {
    var code: String
    var name: String
    var height: Int
    var address: String
    var management: String
    var detail: String
    var summary: String
    var imageURL: String
    var isFamous: Int
}
