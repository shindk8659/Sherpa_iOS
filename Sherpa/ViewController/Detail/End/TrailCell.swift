//
//  TrailCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class TrailCell: UICollectionViewCell {
    
    @IBOutlet private weak var trailNameLabel: UILabel!
    @IBOutlet private weak var hikingTimeLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    
    var trailModel: Trail? {
        didSet {
            if let pathName = trailModel?.attributes?.pathName?.trim() {
                trailNameLabel.text = pathName.isEmpty ? "이름없는 등산로" : pathName
            }
            hikingTimeLabel.text = "\(trailModel?.attributes?.ascendTime ?? 0 + (trailModel?.attributes?.descendTime ?? 0))분"
            distanceLabel.text = "\(trailModel?.attributes?.distance ?? 0)km"
        }
    }
}
