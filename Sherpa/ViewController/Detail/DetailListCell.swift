//
//  DetailDescriptionCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class DetailDescriptionCell: UITableViewCell {
    
   
    
    var model: Recommend? {
        didSet {
            
        }
    }
}

extension DetailCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListCell", for: indexPath) as! DetailListCell
        cell.model = model?[indexPath.item]
        return cell
    }
}

extension DetailCell: UITableViewDelegate {
    
}

class DetailListCell: UITableViewCell {
    
    @IBOutlet private weak var mountainImageView: UIImageView!
    @IBOutlet private weak var mountainNameLabel: UILabel!
    @IBOutlet private weak var mountainDescriptionLabel: UILabel!
    
    var model: Mountain? {
        didSet {
            print(model)
            if let url = URL(string: model?.imageURL ?? "") {
                mountainImageView.kf.setImage(with: url)
            }
            mountainNameLabel.text = model?.name
            mountainDescriptionLabel.text = model?.detail
        }
    }
}
