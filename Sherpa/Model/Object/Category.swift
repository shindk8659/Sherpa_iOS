//
//  Category.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 20..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

enum Category: String {
    case none
    case news
    case mountain
    case education
    case trail
    case weather
    
    static var allValues: [Category] {
        return [.none, .news, .mountain, .education, .trail, .weather]
    }
    
    var cellIdentifier: String {
        switch self {
        case .education: return "EducationCollectionViewCell"
        case .news: return "ArticleCollectionViewCell"
        case .mountain: return "MountainCell"
        default: return ""
        }
    }
}


extension Category {
    
    var value: String {
        return rawValue.uppercased()
    }
}
