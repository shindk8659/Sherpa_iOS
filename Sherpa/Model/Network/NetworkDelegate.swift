//
//  NetworkDelegate.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 5. 22..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class NetworkDelegate{
    
    internal let baseURL1 = "https://dapi.kakao.com/v2/local/geo"
  
    
    var delegate: NetworkCallBack
    
    init(_ delegate: NetworkCallBack) {
        
        self.delegate = delegate
    }
}
