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
    @IBOutlet private weak var mountainDescriptionLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    @IBOutlet private weak var descriptionLabelHeightConstraint: NSLayoutConstraint!
    
    var moreButtonTapped: (() -> Void)?
    
    var mountainModel: Mountain? {
        didSet {
            if let url = URL(string: "http://" + (mountainModel?.imageURL ?? "")) {
                mountainImageView.kf.setImage(with: url)
            }
            mountainNameLabel.text = mountainModel?.name
            mountainHeightLabel.text = "\(mountainModel?.height ?? 0)m"
            mountainAddressLabel.text = mountainModel?.address
            mountainDescriptionLabel.text = mountainModel?.detail
        }
    }
    
    @IBAction func moreButtonTapped(sender: UIButton) {
        let previousHeight = frame.height
        let mountainDescriptionLabelPreviousHeight = mountainDescriptionLabel.frame.height
        mountainDescriptionLabel.removeConstraint(descriptionLabelHeightConstraint)
        mountainDescriptionLabel.frame.size = CGSize(width: mountainDescriptionLabel.frame.width, height: 10000)
        mountainDescriptionLabel.sizeToFit()
        frame.size = CGSize(width: frame.width, height: previousHeight + mountainDescriptionLabel.frame.height - mountainDescriptionLabelPreviousHeight)
        moreButton.isHidden = true
        moreButtonTapped?()
    }
}
