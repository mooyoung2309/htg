//
//  Date+.swift
//  HTG
//
//  Created by 송영모 on 9/17/24.
//

import Foundation

extension Date {
    var str: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    var day: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components.day!
    }
}
