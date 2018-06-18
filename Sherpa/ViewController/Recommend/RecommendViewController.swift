//
//  RecommnedViewController.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 7..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    let recommendList = Recommend.allValues
    var selectedRecommend: Recommend?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == DetailListViewController.identifier {
            let detailViewController = segue.destination as! DetailListViewController
            detailViewController.recommend = selectedRecommend
        }
    }
    
    func moveToDetailPage() {
        performSegue(withIdentifier: DetailListViewController.identifier, sender: nil)
    }
}
