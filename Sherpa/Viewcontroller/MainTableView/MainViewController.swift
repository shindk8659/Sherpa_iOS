//
//  MainViewController.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 7..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
   let mainheaderview = MainHeaderTableViewCell()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        
        
        
        tableview.dataSource = self
        tableview.delegate = self
        let longTitle = UIImageView()
        longTitle.image = #imageLiteral(resourceName: "naviLogo")
        let leftItem = UIBarButtonItem(customView: longTitle)
        self.navigationItem.leftBarButtonItem = leftItem
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}

extension MainViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        print("클릭이 된다")
        
        let firstView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Mainview") as! MainViewController
        let nextView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
        
        
        firstView.parent?.navigationController?.pushViewController(nextView, animated: true)
        
    }
}
extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxCell", for: indexPath) as! MainCVCollectionViewCell
        
        cell.backgroundColor = UIColor.blue
        cell.row.text = String(indexPath.row)
        return cell
    }
    
}






extension MainViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return 2
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }
        else {
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 206
        }
        else{
            return 280
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainHeaderCell") as! MainHeaderTableViewCell
            
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! MainCVTableViewCell
            cell.voiceRecodeLB.text = String(indexPath.row)
            
            return  cell
            
        }
        
    }
    
    
}
extension MainViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
        if tableView == mainheaderview.headertv{
        
       
        let nextView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
        
        self.navigationController?.pushViewController(nextView, animated: true)
        
    }
        else{
            
        }
    
    
    
    
    }
    
}
