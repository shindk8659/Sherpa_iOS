//
//  DetailMountainViewController.swift
//  Sherpa
//
//  Created by DanBee on 2018. 6. 15..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class DetailMountainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var mountain: Mountain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setNavigationBar() {
        let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftItem
    }
}
