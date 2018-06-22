//
//  Date+Extension.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 22..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

extension Date {
    
    static func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        
        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = "MMM d, h:mm a"
        
        let date: Date = dateFormatter.date(from: date) ?? Date()
        return resultFormatter.string(from: date)
    }
}
