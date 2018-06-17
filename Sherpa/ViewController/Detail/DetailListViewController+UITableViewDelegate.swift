//
//  DetailListViewController+UITableViewDelegate.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

extension DetailListViewController: UITableViewDelegate {
    
}

extension DetailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mountains?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListCell", for: indexPath) as! DetailListCell
        cell.model = mountains?[indexPath.row]
        return cell
    }
}
