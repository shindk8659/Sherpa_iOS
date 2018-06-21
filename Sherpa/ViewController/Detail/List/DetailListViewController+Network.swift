//
//  DetailListViewController+Network.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension DetailListViewController {
    
    func requestRecommendedMountains(pageNo: Int, completion: @escaping ([Mountain]?) -> Void) {
        var parameters = recommend?.parameters ?? [:]
        parameters["pageNo"] = pageNo
        let router = APIRouter(url: recommend?.endPoint ?? "", method: .get, parameters: parameters)
        NetworkRequestor(with: router).request { (mountains: [Mountain]?, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(mountains)
        }
    }
}
