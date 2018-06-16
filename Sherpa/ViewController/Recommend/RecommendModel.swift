//
//  RecommendModel.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

enum Recommend {
    case famous
    case nearToSeoul
    case easy
    case difficult
    case withBaby
    case autumn
    case popular
    case valley
    
    var endPoint: String {
        switch self {
        case .famous: return "/getFamousMountains"
        case .nearToSeoul: return "/getAroundMountains?city=서울"
        case .easy: return "/getEasyMountains"
        case .difficult: return "/getDifficultMountains"
        case .withBaby: return "/withBaby"
        case .autumn: return "/getAutumnMountains"
        case .popular: return "/getPopularMountains"
        case .valley: return "/getVallyMountains"
        }
    }
    
    static let allValues: [Recommend] = [
        .famous, .nearToSeoul, .easy, .difficult, .withBaby, .autumn, .popular, .valley
    ]
}

struct RecommendModel {
    let title: String
    let image: UIImage
}

struct RecommendDummy {
    static let list: [RecommendModel] = [
        RecommendModel(title: "산림청이 선정한 명산", image: #imageLiteral(resourceName: "mountain8-min")),
        RecommendModel(title: "서울에 가까운산", image: #imageLiteral(resourceName: "mountain5-min")),
        RecommendModel(title: "처음 도전하기 좋은 산", image: #imageLiteral(resourceName: "mountain4-min")),
        RecommendModel(title: "히말라야 가기전 들러야하는 산", image: #imageLiteral(resourceName: "mountain1-min")),
        RecommendModel(title: "아이들 데리고 가기 좋은 산", image: #imageLiteral(resourceName: "mountain2-min")),
        RecommendModel(title: "가을철 가기 좋은 산", image: #imageLiteral(resourceName: "mountain7-min")),
        RecommendModel(title: "인기많은 산", image: #imageLiteral(resourceName: "sampleMountain")),
        RecommendModel(title: "계곡이 있는 산", image: #imageLiteral(resourceName: "mountain3-min")),
    ]
}
