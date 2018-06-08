//
//  MainHeaderTableViewCell.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 3..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class MainHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headertv: UITableView!
    
    
    override func awakeFromNib() {
        
        headertv.delegate = self
        headertv.dataSource = self
   
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
extension MainHeaderTableViewCell: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        let firstView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"Mainview") as! MainViewController
        let nextView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
        
        firstView.navigationController?.pushViewController(nextView, animated: true)
       
//        mainview.navigationController?.pushViewController(nextView, animated: true)
  
    }
    
}
extension MainHeaderTableViewCell: UITableViewDataSource{
    
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 11
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView:UIView = UIView()
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
   
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section ==  0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderTableViewCell
            
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        
            let borderColor: UIColor = UIColor.gray
            cell.layer.borderColor = borderColor.cgColor

        
        return cell
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderTableViewCell
            
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            
            let borderColor: UIColor = UIColor.gray
            cell.layer.borderColor = borderColor.cgColor
            
            
            return cell
            
        }
    }
    
    
}
