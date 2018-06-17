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
    
    var description: String {
        switch self {
        case .famous: return """
            산림청이 선정한 명산!
            우리나라 산에 대한 모든 정보가 있는 산림청에서 추천하는 명산리스트. 국가 기관에서 추천하는 명산인 만큼 꼭 한번 가보도록하자.
            """
        case .nearToSeoul: return """
            셰르파가 추천하는 서울에 가까운산!
            산은 지방에 있는 산이 멋있고 좋다는 생각은 버리자. 서울에도 아름다운 산들이 많다. 이번주 주말에는 서울에 있는 산에 가보는 것은 어떨까?
            """
        case .easy: return """
            셰르파가 추천하는 초보자도 오르기 쉬운 산!
            주말에 운동을 하고는 싶은데, 너무 어렵지 않은 산을 찾는다면 이 산들을 올라보도록 하자. 쉬엄쉬엄 오르기 좋은 산들이니 부담없이 등산을 즐길 수 있다.
            """
        case .difficult: return """
            셰르파가 추천하는 난이도 높은 산!
            히말라야 같이 높은 산들, 동네 주변 산들이 너무 쉬웠다면 이 산들을 도전해보도록 하자. 정상에서 느끼는 뿌듯함은 2배가 될 것이다.
            """
        case .withBaby: return """
            셰르파가 추천하는 아이와 함께 가기 좋은 산!
            주말을 맞이하여 우리 아이들을 데리고 갈만한 산이 어딨을까? 아이들도 즐겁게 오를 수 있는 산으로 가족 모두 즐길 수 있다.
            """
        case .autumn: return """
            셰르파가 추천하는 가을에 가기 좋은 산!
            익어가는 단풍과 함께 마음이 허전한 가을, 책 한권들고 셰르파가 추천하는 가을 명산에서 읽어보는 것은 어떨까요?
            """
        case .popular: return """
            등산 애호가들에게 인기 좋은 산!
            산에 대해 잘 모른다면 일단 인기 많은 산부터 가보자. 많은 사람들과 함께 가벼운 인사도 나누며 즐겁게 산행해보자.
            """
        case .valley: return """
            무더운 여름엔 계곡이 있는 산!
            물 흐르는 소리와 함께 산을 올라보자. 깨끗한 계곡 물은 등산하는 이의 마음도 깨끗하게 씻겨줄 것이다.
            """
        }
    }
    
    var endPoint: String {
        switch self {
        case .famous: return "/getFamousMountains"
        case .nearToSeoul: return "/getAroundMountains"
        case .easy: return "/getEasyMountains"
        case .difficult: return "/getDifficultMountains"
        case .withBaby: return "/withBaby"
        case .autumn: return "/getAutumnMountains"
        case .popular: return "/getPopularMountains"
        case .valley: return "/getVallyMountains"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .nearToSeoul: return ["city": "서울"]
        default: return [:]
        }
    }
    
    static let allValues: [Recommend] = [
        .famous, .nearToSeoul, .easy, .difficult, .withBaby, .autumn, .popular, .valley
    ]
}
