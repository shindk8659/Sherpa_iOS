//
//  ArticleCollectionViewCell.swift
//  Sherpa
//
//  Created by DanBee on 2018. 6. 18..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

protocol CollectionViewModelRepresentable {
    var model: ModelTransformable? { get set }
    func didSelectedAction()
}

extension CollectionViewModelRepresentable {
    func didSelectedAction() { }
}

class ArticleCollectionViewCell: UICollectionViewCell, CollectionViewModelRepresentable {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    
    var model: ModelTransformable? {
        didSet {
            let article = model as! Article
            timeLabel.text = Date.formatDate(date: article.pubDate)
            titleLabel.text = article.title
            bodyLabel.text = article.description
        }
    }
    
    func didSelectedAction() {
        let article = model as! Article
        if let url = URL(string: article.link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
