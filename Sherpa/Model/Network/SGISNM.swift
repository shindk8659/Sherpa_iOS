//
//  SGISNM.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 5. 30..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON

class SGISNM : NetworkDelegate{
    
    func getToken(){
    
        let url = "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json?consumer_key=87926edeae3a4116b6f5&consumer_secret=a734f837c98a4d05bf0d"
        

    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<SGISVO>) in
            
            switch response.result{
                
            case .success :
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if let resultdoc  = value.result{
                    self.delegate.networkResultData(resultData: resultdoc, code: "success getToken")
                }
            case .failure(let err) :
                
                print("네트워크 접속 실패")
                print(err.localizedDescription)
                self.delegate.networkFailed(msg: "")
            }
        }
    }
    
}
