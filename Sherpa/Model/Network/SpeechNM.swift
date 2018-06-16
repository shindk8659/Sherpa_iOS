//
//  SpeechNM.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Realm
import RealmSwift

class SpeechNM: NetworkDelegate{
    
    
    func SpeechSend(comment: Results<SpeachStringresult>){
        print("send실행")
      let URL = "\(baseURL)/sendVoice"
        
        let concurrentQueue = DispatchQueue(label: "speechload", attributes: .concurrent)
        
        concurrentQueue.sync {
            for i in 0..<comment.count{
                let parameter = [
                    "content" : comment[i].stringdata
                ]
                Alamofire.request(URL, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<SpeechVO>) in

            switch response.result{
            case .success :
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.result == 200 {

                    print("네트워크 접속 성공")
                    self.delegate.networkResultData(resultData: value, code: "sendspeech")

                }
                else{
                    print("파라미터오류")
                    print(value.result)
                    self.delegate.networkResultData(resultData: value, code: "parametererror")
                    
                }

                break
            case .failure(let err) :

                print("네트워크 접속 실패")
                print(err.localizedDescription)
                self.delegate.networkFailed(msg: "")
                break
            }
                }
                
            }
            
        }
        
        
    }
    
}
