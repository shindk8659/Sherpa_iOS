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
    
    var title: String {
        switch self {
        case .famous: return "산림청이 선정한 명산"
        case .nearToSeoul: return "서울에 가까운산"
        case .easy: return "처음 도전하기 좋은 산"
        case .difficult: return "히말라야 가기전 들러야하는 산"
        case .withBaby: return "아이들 데리고 가기 좋은 산"
        case .autumn: return "가을철 가기 좋은 산"
        case .popular: return "인기많은 산"
        case .valley: return "계곡이 있는 산"
        }
    }
    
    var backgroundImage: UIImage {
        switch self {
        case .famous: return #imageLiteral(resourceName: "mountain8-min")
        case .nearToSeoul: return #imageLiteral(resourceName: "mountain5-min")
        case .easy: return #imageLiteral(resourceName: "mountain4-min")
        case .difficult: return #imageLiteral(resourceName: "mountain1-min")
        case .withBaby: return #imageLiteral(resourceName: "mountain2-min")
        case .autumn: return #imageLiteral(resourceName: "mountain7-min")
        case .popular: return #imageLiteral(resourceName: "sampleMountain")
        case .valley: return #imageLiteral(resourceName: "mountain3-min")
        }
    }
    
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
