//
//  UIViewController+Extension.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

protocol StoryBoardIdentifiable {
    static var identifier: String { get }
}

extension StoryBoardIdentifiable where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryBoardIdentifiable { }
