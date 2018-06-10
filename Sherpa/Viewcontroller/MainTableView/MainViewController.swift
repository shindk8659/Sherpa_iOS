//
//  MainViewController.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 7..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIGestureRecognizerDelegate {

    
    let mainheaderview = MainHeaderTableViewCell()
    
    var tablex :CGFloat = 0.0
    var tabley :CGFloat = 0.0
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var micBtn: UIButton!
    @IBOutlet weak var cancelmicBtn: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        //tableview 제스처 시 원래 화면으로 돌리기 
        let tvGesture = UIPanGestureRecognizer(target: self, action: #selector(cancelmic))
        tvGesture.delegate = self
        self.tableview.addGestureRecognizer(tvGesture)
        
        
        //네이게이션바 타이틀
        let longTitle = UIImageView()
        longTitle.image = #imageLiteral(resourceName: "naviLogo")
        let leftItem = UIBarButtonItem(customView: longTitle)
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cancelmic()
    }
    
    // 제스처가 두개 일경우 둘다 허용하는 코드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
    
    @objc func cancelmic(){
        cancelmicBtn.isHidden = true
        micBtn.isHidden = false
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tableview.frame.origin.y = 0
        }, completion: nil)
        navigationController?.setNavigationBarHidden(false, animated: true)
        setTabBarHidden(false)
        
    }
    
    @IBAction func cancelmicAction(_ sender: Any) {
        
        cancelmic()
      
        
    }
    
  
    
    @IBAction func micAction(_ sender: Any) {
        
        cancelmicBtn.isHidden = false
        micBtn.isHidden = true
        
        let xsize = tableview.frame.size.width
        let ysize = tableview.frame.size.height
        tablex = xsize
        tabley = ysize
    

        
        UIView.animate(withDuration: 0.2, animations: {
                        self.tableview.frame.origin.y = -(ysize*0.39)
        }, completion: nil)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setTabBarHidden(true)

        
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
            return 10
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
            cell.didSelectTableView = {[weak self] in let nextview = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
                
                self?.navigationController?.pushViewController(nextview, animated: true)
            }
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! MainCVTableViewCell
            cell.voiceRecodeLB.text = String(indexPath.row)
            cell.didSelectCollectionView = {[weak self] in let nextView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
                
                self?.navigationController?.pushViewController(nextView, animated: true)
                
            }
            
            
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
      
    
    
    
    
    }
    
}
