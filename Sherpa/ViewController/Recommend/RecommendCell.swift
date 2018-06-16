//
//  RecommendCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var model: RecommendModel? {
        didSet {
            backgroundImageView.image = model?.image
            titleLabel.text = model?.title
        }
    }
}
