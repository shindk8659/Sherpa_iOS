//
//  NetworkDelegate.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class NetworkDelegate{
    
    internal let baseURL = "http://52.78.104.4:8080"
    var delegate: NetworkCallBack
    
    init(_ delegate: NetworkCallBack) {
        self.delegate = delegate
    }
}
