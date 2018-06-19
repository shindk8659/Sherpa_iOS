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
import RealmSwift
import Realm

class SpeechNM{
    
    func FirstSpeechSend(realm: Results<SpeechStringresult>, completion: @escaping (SpeechVO?) -> Void) {
        
        print("시작")
        
        let url = "http://52.78.104.4:8080/sendVoice"
        
        for i in 0..<realm.count{
            
            let parameters = ["input": realm[i].stringdata]
            
            Alamofire.request(url, parameters: parameters).responseJSON { response in
                switch response.result{
                case .success:
                    
                    if let data = response.data {
                        do {
                            if JSON(data)["result"] == 200{
                                let speech = try JSONDecoder().decode(SpeechVO.self, from: data)
                                completion(speech)
                                
                            }
                            else{
                                
                                print("실패")
                            }
                            
                        } catch let error {
                            
                            print(error)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
       
        
        
        
    }
    
    
    func SpeechSend(string: String, completion: @escaping (SpeechVO?) -> Void) {
        
        let url = "http://52.78.104.4:8080/sendVoice"
        
        let parameters = ["input": string]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            switch response.result{
            case .success:
              
                if let data = response.data {
                    do {
                        if JSON(data)["result"] == 200{
                        let speech = try JSONDecoder().decode(SpeechVO.self, from: data)
                            completion(speech)
                            
                        }
                        else{
                            
                            print("실패")
                        }
                        
                    } catch let error {
                    
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
       
        
    }
    
    
}
