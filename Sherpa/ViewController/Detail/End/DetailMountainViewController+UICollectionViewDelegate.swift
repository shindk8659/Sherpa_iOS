//
//  DetailMountainViewController+UICollectionViewDelegate.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

extension DetailMountainViewController: UICollectionViewDelegate {
    
}

extension DetailMountainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DetailDescriptionReusableView", for: indexPath) as! DetailDescriptionReusableView
            view.mountainModel = mountain
        }
    }
}
