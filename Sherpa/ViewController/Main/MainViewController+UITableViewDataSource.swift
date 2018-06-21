//
//  MainViewController+UITableViewDataSource.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 20..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(SpeechStringResult.self).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = realm.objects(SpeechStringResult.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! MainCVTableViewCell
        
        cell.voiceRecodeLB.text = object[indexPath.row].stringdata
        cell.voiceRecodeLB.sizeToFit()
        cell.didSelectCollectionView = {[weak self] in
            let nextView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
            self?.micStringLB.text = ""
            self?.stopListening()
            self?.navigationController?.pushViewController(nextView, animated: true)
        }
        
        return cell
    }
}
