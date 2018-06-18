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
        guard let endPoint = recommend?.endPoint else {
            return
        }
        let url = "http://52.78.104.4:8080\(endPoint)"
        var parameters = recommend?.parameters ?? [:]
        parameters["pageNo"] = pageNo
        Alamofire.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let jsonString = JSON(data)["meta"].description
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        let mountains = try JSONDecoder().decode([Mountain].self, from: jsonData)
                        completion(mountains)
                    } catch let error {
                        print(error)
                    }
                }
            case .failure:
                break
            }
        }
    }
}
