//
//  MainViewController.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 7..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Speech

class MainViewController: UIViewController,UIGestureRecognizerDelegate,NVActivityIndicatorViewable ,SFSpeechRecognizerDelegate{

    
    let mainheaderview = MainHeaderTableViewCell()
    
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20),
                                                                  type: NVActivityIndicatorType(rawValue: 23)!)
    // 마이크 애니메이션 액티비티 인디케이터 뷰
    
    
    
    var tablex :CGFloat = 0.0
    var tabley :CGFloat = 0.0
    

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var micBtn: UIButton!
    @IBOutlet weak var cancelmicBtn: UIButton!
    @IBOutlet weak var micStringLB: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        speechRecognizer?.delegate = self
       
        self.view.addSubview(activityIndicatorView)


        tableview.dataSource = self
        tableview.delegate = self
        
        
        micStringLB.isHidden = true
        
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
    // 마이크 레코딩
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("SFSpeechAudioBufferRecognitionRequest() 요청되지않습니다.")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.micStringLB.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
                self.micStringLB.sizeToFit()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.cancelmic()
                }
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("에러입니다.")
        }
        
        micStringLB.text = "듣고있습니다 :)"
        
    }
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            micBtn.isEnabled = true
        } else {
            micBtn.isEnabled = false
        }
    }
    
    // 제스처가 두개 일경우 둘다 허용하는 코드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
  

    
    @objc func cancelmic(){
        audioEngine.stop()// 레코딩 멈춤
        recognitionRequest?.endAudio() //오디오를 끔
    
        
        cancelmicBtn.isHidden = true
        micBtn.isHidden = false
        activityIndicatorView.stopAnimating()
        micStringLB.text = ""
        micStringLB.isHidden = true
        
        //애니메이션 적용 해서 네비바와 탭바 생성 후 테이블뷰 내림
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
        
        startRecording()// 레코딩 시작
        
        activityIndicatorView.color = UIColor.blue
        activityIndicatorView.frame.size.width = 142
        activityIndicatorView.frame.size.height = 142
        activityIndicatorView.frame.origin.y = ysize - 200
        activityIndicatorView.frame.origin.x = (xsize/2) - (142/2)
        activityIndicatorView.startAnimating()
        
        
      
        
        
        
        //애니메이션 적용 해서 네비바와 탭바 제거 후 테이블뷰 올림
        UIView.animate(withDuration: 0.2, animations: {
                        self.tableview.frame.origin.y = -(ysize*0.39)
        }, completion: nil)
        
     
        navigationController?.setNavigationBarHidden(true, animated: true)
        setTabBarHidden(true)
        
        micStringLB.isHidden = false
        micStringLB.frame.origin.y = ysize - (ysize*0.35)
        micStringLB.frame.origin.x = 10
        micStringLB.sizeToFit()
    
        
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
            return 0
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
