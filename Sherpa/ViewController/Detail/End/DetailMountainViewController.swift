//
//  DetailMountainViewController.swift
//  Sherpa
//
//  Created by DanBee on 2018. 6. 15..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import CoreLocation

class DetailMountainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var mountain: Mountain?
    var trails: [Trail]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var headerSize = CGSize(width: UIScreen.main.bounds.width, height: 480)
    
    var tokenObject: Access?
    var wgsModel: GetWGSNM?
    var convertedPaths = [(Int, Result?)]() {
        didSet {
            var pathCount = 0
            trails?.forEach {
                pathCount += $0.paths?.count ?? 0
            }
            if convertedPaths.count == pathCount {
                collectionView.reloadData()
            }
        }
    }
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWGSModels()
        setNavigationBar()
        requestTrails { [weak self] trails in
            self?.trails = trails
            self?.transformXY(trails: trails)
        }
        requestLocationAuth()
    }
    
    func setWGSModels() {
        let tokenModel = SGISNM(self)
        tokenModel.getToken()
        wgsModel = GetWGSNM(self)
    }
    
    func transformXY(trails: [Trail]?) {
        trails?.enumerated().forEach { index, element in
            let paths = element.paths
            paths?.forEach { path in
                let x = path[0]
                let y = path[1]
                wgsModel?.getwgs(x: String(x), y: String(y), token: tokenObject?.accessToken ?? "", index: index)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == MapViewController.identifier {
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! MapViewController
            destination.paths = convertedPaths.filter { $0.0 == indexPath.item }
                                              .map { $0.1 }
            destination.trail = trails?[indexPath.item]
        }
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

extension DetailMountainViewController: NetworkCallBack {
    
    func networkResultData(resultData: Any, code: String) {
        if code == "success getWGS"{
            if let resultData = resultData as? (Int, Result?) {
                convertedPaths.append(resultData)
            }
        } else {
            tokenObject = resultData as? Access
        }
    }
}

extension DetailMountainViewController: CLLocationManagerDelegate {
    
    func requestLocationAuth() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
    }
}
