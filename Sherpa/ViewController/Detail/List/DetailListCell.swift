//
//  DetailDescriptionCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class DetailListCell: UITableViewCell {
    
    @IBOutlet private weak var mountainImageView: UIImageView!
    @IBOutlet private weak var mountainNameLabel: UILabel!
    @IBOutlet private weak var mountainDescriptionLabel: UILabel!
    
    var model: Mountain? {
        didSet {
            mountainNameLabel.text = model?.name
            mountainDescriptionLabel.text = model?.detail
            if let url = URL(string: "http://" + (model?.imageURL ?? "")) {
                mountainImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "mountainDetault"))
            }
        }
    }
}
