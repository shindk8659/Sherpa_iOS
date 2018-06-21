//
//  MainCVTableViewCell.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 3..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class MainCVTableViewCell: UITableViewCell {

    var responseVO = [Mountain]()
    
    @IBOutlet weak var orderCV: UICollectionView!
    @IBOutlet weak var voiceRecodeLB: UILabel!
    
    var didSelectCollectionView: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderCV.delegate = self
        orderCV.dataSource = self
    }
}

extension MainCVTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCollectionView?()
    }
}

extension MainCVTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxCell", for: indexPath) as! CVCollectionViewCell
        cell.backgroundColor = UIColor.blue
        cell.row.text = String(indexPath.row)
        return cell
    }
}



