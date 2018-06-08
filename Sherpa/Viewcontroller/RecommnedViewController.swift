//
//  RecommnedViewController.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 7..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class RecommnedViewController: UIViewController {

    override func viewDidLoad() {
      
        let longTitle = UIImageView()
        longTitle.image = #imageLiteral(resourceName: "naviLogo")
        let leftItem = UIBarButtonItem(customView: longTitle)
        self.navigationItem.leftBarButtonItem = leftItem
    
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   

}
