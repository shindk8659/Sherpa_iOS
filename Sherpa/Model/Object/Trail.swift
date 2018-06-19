//
//  Trail.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

struct TrailAttribute {
    var pathName: String?
    var difficulty: String?
    var ascendTime: Int?
    var descendTime: Int?
    var distance: Double?
    
    init(pathName: String?, difficulty: String?, ascendTime: Int?, descendTime: Int?, distance: Double?) {
        self.pathName = pathName
        self.difficulty = difficulty
        self.ascendTime = ascendTime
        self.descendTime = descendTime
        self.distance = distance
    }
}

struct Trail {
    var attributes: TrailAttribute?
    var paths: [[Double]]?
}
