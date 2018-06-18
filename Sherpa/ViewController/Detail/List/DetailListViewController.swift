//
//  DetailListViewController.swift
//  Sherpa
//
//  Created by DanBee on 2018. 6. 15..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class DetailListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var recommend: Recommend?
    var mountains: [Mountain]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDescriptionUI()
        setNavigationBar()
        requestRecommendedMountains(pageNo: 1) { [weak self] mountains in
            self?.mountains = mountains
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == DetailMountainViewController.identifier {
            let detailMountainViewController = segue.destination as! DetailMountainViewController
            detailMountainViewController.mountain = sender as? Mountain
        }
    }
    
    func updateDescriptionUI() {
        thumbnailImageView.image = recommend?.backgroundImage
        titleLabel.text = recommend?.title
        descriptionTextView.text = recommend?.description
    }
    
    func moveToDetail(with mountain: Mountain?) {
        performSegue(withIdentifier: DetailMountainViewController.identifier, sender: mountain)
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

