//
//  DetailDescriptionReusableView.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class DetailDescriptionReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var mountainImageView: UIImageView!
    @IBOutlet private weak var mountainNameLabel: UILabel!
    @IBOutlet private weak var mountainHeightLabel: UILabel!
    @IBOutlet private weak var mountainAddressLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var rainfallLabel: UILabel!
    @IBOutlet private weak var mountainDescriptionTextView: UITextView!
    @IBOutlet private weak var moreButton: UIButton!
    
    var moreButtonTapped: (() -> Void)?
    
    var mountainModel: Mountain? {
        didSet {
            if let url = URL(string: mountainModel?.imageURL ?? "") {
                mountainImageView.kf.setImage(with: url)
            }
            mountainNameLabel.text = mountainModel?.name
            mountainHeightLabel.text = "\(mountainModel?.height ?? 0)m"
            mountainAddressLabel.text = mountainModel?.address
            mountainDescriptionTextView.text = mountainModel?.detail
        }
    }
    
    @IBAction func moreButtonTapped(sender: UIButton) {
        print(frame.height)
        moreButtonTapped?()
    }
}
