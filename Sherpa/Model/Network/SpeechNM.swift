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

enum SpeechError: Error {
    case emptyCategory
}

class SpeechNM {
    
    /*
    func sendPreviousSpeeches(realm: Results<SpeechStringResult>, completion: @escaping (SpeechVO?) -> Void) {
        
        print("시작")
        
        let url = "http://52.78.104.4:8080/sendVoice"
        
        for i in 0..<realm.count {
            
            let parameters = ["input": realm[i].stringdata]
            
            Alamofire.request(url, parameters: parameters).responseJSON { response in
                switch response.result{
                case .success:
                    if let data = response.data {
                        do {
                            if JSON(data)["result"] == 200 {
                                let speech = try JSONDecoder().decode(SpeechVO.self, from: data)
                                completion(speech)
                            } else {
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
    */
    
    func sendSpeech(string: String, completion: @escaping (Category?, [ModelTransformable]?, Error?) -> Void) {
        
        let apiRouter = APIRouter(url: "/sendVoice", method: .get, parameters: ["input": string])
        NetworkRequestor(with: apiRouter).requestJSON { json, error in
            guard error == nil else {
                completion(nil, nil, error)
                return
            }
            guard let category = Category.allValues.first(where: { category in
                category.value == (json?["meta"]["Category"].stringValue ?? "")
            }) else {
                completion(nil, nil, SpeechError.emptyCategory)
                return
            }

            let jsonString = json?["meta"]["response"].description
            let jsonData = jsonString?.data(using: .utf8) ?? Data()
            do {
                switch category {
                case .education:
                    let result = try JSONDecoder().decode([Education].self, from: jsonData)
                    completion(.education, result, nil)
                case .mountain:
                    let result = try JSONDecoder().decode([Mountain].self, from: jsonData)
                    completion(.mountain, result, nil)
                case .news:
                    let result = try JSONDecoder().decode([Article].self, from: jsonData)
                    completion(.news, result, nil)
                case .trail:
                    break
                case .weather:
                    break
                default:
                    break
                }
            } catch let error {
                print(error)
                completion(nil, nil, error)
            }
        }
    }
}
