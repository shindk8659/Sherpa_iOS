//
//  BaseNavigationViewController.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationBar.shadowImage = UIImage()
    }
}