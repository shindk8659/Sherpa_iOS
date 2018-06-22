//
//  Article.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 22..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

struct Article: Codable, ModelTransformable {
    var title: String
    var link: String
    var description: String
    var pubDate: String
}
