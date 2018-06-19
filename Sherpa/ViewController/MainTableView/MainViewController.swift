//
//  MainViewController.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 7..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Realm
import RealmSwift
import Speech

class MainViewController: UIViewController,SFSpeechRecognizerDelegate, UIGestureRecognizerDelegate,NVActivityIndicatorViewable{

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var networkflag : Int = 0
    var speechVO : [SpeechMeta] = [] {
        didSet {
            if micStringLB.text != ""{
            self.addspeechData(string: self.gsno(self.micStringLB.text))
                print("카운트세기"+"\(speechVO.count)")
            }
            let count = speechVO.count
             print("speechVO에 담겨저있는 데이터 배열 category \(speechVO[count - 1].response!)")
             print("speechVO에 담겨저있는 데이터 배열 갯수 \(count)")
            tableview.reloadData()
            tableview.scrollToBottom()
        }
    }
    let realm = try! Realm()

    let mainheaderview = MainHeaderTableViewCell()
    
    
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20),
                                                                  type: NVActivityIndicatorType(rawValue: 23)!)
    let micimg = UIImageView()
    // 마이크 애니메이션 액티비티 인디케이터 뷰
    var detectionTimer = Timer()
    
    var tablex :CGFloat = 0.0
    var tabley :CGFloat = 0.0
    var isListening: Bool = false
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var micBtn: UIButton!
    @IBOutlet weak var cancelmicBtn: UIButton!
    @IBOutlet weak var micStringLB: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //네트워크
        let firstNM = SpeechNM()
        print(micStringLB.text )
        firstNM.FirstSpeechSend(realm: realm.objects(SpeechStringresult.self)){ [weak self] speech in
            self?.speechVO.append((speech?.meta)!)
                
        }
      
        //////////

        speechRecognizer?.delegate = self
        
        self.view.addSubview(activityIndicatorView)
        self.view.addSubview(micimg)
        micimg.isHidden = true
        


        tableview.dataSource = self
        tableview.delegate = self
        
       
        
        micStringLB.isHidden = true
        cancelmicBtn.isHidden = true
        
        //tableview 제스처 시 원래 화면으로 돌리기
        let tvGesture = UIPanGestureRecognizer(target: self, action: #selector(stopListening))
        tvGesture.delegate = self
        self.tableview.addGestureRecognizer(tvGesture)

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        stopListening()
    }
    
    
    
    //Realm 데이터 저장
    func addspeechData(string: String){
        
        let speechdata = SpeechStringresult()
        speechdata.stringdata = string
        
        try! realm.write {
            realm.add(speechdata)
        }
        print("저장")
        print(speechdata)
        
        
    }
    // 마이크 레코딩
    func startListening() {
        guard !isListening else {return}
        isListening = true
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            return
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error)  in
            if self.audioEngine.isRunning{
           
            
                if result != nil {
                self.micStringLB.text = result?.bestTranscription.formattedString
                self.micStringLB.sizeToFit()
                
            }
           
            let timer = self.detectionTimer
            if !timer.isValid {
                print("녹음타이머 가동중")
                self.detectionTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                    print("녹음타이머 끝")
                   
                    if self.micStringLB.text != "듣고있습니다:)" && self.micStringLB.text != ""{
                        let speechnetwork = SpeechNM()
                        speechnetwork.SpeechSend(string: self.gsno(self.micStringLB.text) ){ [weak self] speech in
                            self?.speechVO.append((speech?.meta)!)
                            
                        
                        }
                        
                    }
                
                    timer.invalidate()
                    self.stopListening()
                    
                    
                    
                })
                }
                
            }

        })
        
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("오디오 세션이 정확히 준비되지않았다.")
        }
        
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            self.micStringLB.text = "듣고있습니다:)"
        } catch {
            print("오디오엔진 시작을 실패했습니다.")
        }
    }
  
    
    @objc func stopListening() {
        guard isListening else {return}
        
        micimg.isHidden = true
        cancelmicBtn.isHidden = true
        micBtn.isHidden = false
        activityIndicatorView.stopAnimating()
        micStringLB.isHidden = true
        
        //애니메이션 적용 해서 네비바와 탭바 생성 후 테이블뷰 내림
        UIView.animate(withDuration: 0.2, animations: {
            self.tableview.frame.origin.y = 0
        }, completion: nil)
        
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        setTabBarHidden(false)
        
        //오디오 관련 멈춤
       
        audioEngine.reset()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        // Indicate that the audio source is finished and no more audio will be appended
        
        recognitionRequest = nil
        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest?.endAudio()
    
        isListening = false
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
  
    
    @IBAction func cancelmicAction(_ sender: Any) {
        
             stopListening()
            tableview.scrollToBottom()
        
    }
    
  
    
    @IBAction func micAction(_ sender: Any) {
        if audioEngine.isRunning == false{
            
            
            
        startListening()
        
       
            
        cancelmicBtn.isHidden = false
        micBtn.isHidden = true
        
        
        let xsize = tableview.frame.size.width
        let ysize = tableview.frame.size.height
        tablex = xsize
        tabley = ysize
            
        activityIndicatorView.color = UIColor(red:0.04, green:0.27, blue:0.24, alpha:1.0)
        activityIndicatorView.frame.size.width = 170
        activityIndicatorView.frame.size.height = 170
        activityIndicatorView.frame.origin.y = ysize - 200
        activityIndicatorView.frame.origin.x = (xsize/2) - (170/2)
        activityIndicatorView.startAnimating()
        
        micimg.image = #imageLiteral(resourceName: "micButton")
        micimg.frame.size.width = 97.6
        micimg.frame.size.height = 97.6
        micimg.center = activityIndicatorView.center
        micimg.isHidden = false
            
       
        
        
        
        //애니메이션 적용 해서 네비바와 탭바 제거 후 테이블뷰 올림
        UIView.animate(withDuration: 0.2, animations: {
                        self.tableview.frame.origin.y = -(ysize*0.39)
        }, completion: nil)
        self.tableview.scrollToBottom()
     
        navigationController?.setNavigationBarHidden(true, animated: true)
        setTabBarHidden(true)
        
        micStringLB.isHidden = false
        micStringLB.frame.origin.y = ysize - (ysize*0.35)
        micStringLB.frame.origin.x = 10
        micStringLB.sizeToFit()
        }
        
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
            return realm.objects(SpeechStringresult.self).count
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
        
       let object = realm.objects(SpeechStringresult.self)
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainHeaderCell") as! MainHeaderTableViewCell
            cell.didSelectTableView = {[weak self] in let nextview = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
                self?.micStringLB.text = ""
                self?.stopListening()
                self?.navigationController?.pushViewController(nextview, animated: true)
            }
            
            return cell
        }
        else {
         
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! MainCVTableViewCell
           
            
            cell.voiceRecodeLB.text = object[indexPath.row].stringdata
            cell.voiceRecodeLB.sizeToFit()
            cell.didSelectCollectionView = {[weak self] in let nextView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Infomation") as! InfoViewController
                self?.micStringLB.text = ""
                self?.stopListening()
                
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

