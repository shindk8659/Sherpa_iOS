//
//  DetailMountainViewController+UICollectionViewDelegate.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

extension DetailMountainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 45) / 2
        let height = CGFloat(203)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return headerSize
    }
}

extension DetailMountainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = trails?.count else{
            return 0
        }
        return count > 10 ? 10 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrailCell
        cell.trailModel = trails?[indexPath.item]
        cell.position = convertedPaths.filter { $0.0 == indexPath.item }
                                      .map { $0.1 }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DetailDescriptionReusableView", for: indexPath) as! DetailDescriptionReusableView
        view.mountainModel = mountain
        view.moreButtonTapped = { [weak self] in
            self?.headerSize = view.frame.size
            collectionView.reloadData()
        }
        return view
    }
}
