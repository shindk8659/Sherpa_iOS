//
//  DetailMountainViewController+Network.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 18..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

extension DetailMountainViewController {
    
    func requestTrails(completion: @escaping ([Trail]) -> Void) {
        let router = APIRouter(url: "/getTrailInfo?code=\(mountain?.code ?? "")", method: .get)
        NetworkRequestor(with: router).requestJSON { json, error in
            guard error == nil else {
                return
            }
            let features = json?["meta"]["features"].arrayValue
            var trails = [Trail]()
            features?.forEach {
                let attributes = $0["attributes"]
                let trailAttribute = TrailAttribute(pathName: attributes["PMNTN_NM"].string, difficulty: attributes["PMNTN_DFFL"].string, ascendTime: attributes["PMNTN_UPPL"].int, descendTime: attributes["PMNTN_GODN"].int, distance: attributes["PMNTN_LT"].double)
                let paths = $0["geometry"]["paths"].arrayObject?.first as? [[Double]]
                let trail = Trail(attributes: trailAttribute, paths: paths)
                trails.append(trail)
            }
            if trails.count > 10 {
                trails.removeSubrange(10...)
            }
            completion(trails)
        }
    }
}
