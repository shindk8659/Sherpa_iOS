//
//  MainViewController + SFSpeechRecognizerDelegate.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 20..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Speech

extension MainViewController: SFSpeechRecognizerDelegate {
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        micBtn.isEnabled = available
    }
}
