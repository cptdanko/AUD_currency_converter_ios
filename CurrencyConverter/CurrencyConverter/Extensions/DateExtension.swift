//
//  DateExtension.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 25/3/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation

extension Date {
    var time: String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss"
        return format.string(from: self)
    }
    var dateOnlyStr: String {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        return format.string(from: self)
    }
    var dateStr: String {
        let format = DateFormatter()
        format.dateFormat = "MMM dd,yyyy hh:MM aa"
        return format.string(from: self)
    }
    func isDateOnSameDay(targetDate: Date) -> Bool {
        let result = Calendar.current.compare(self, to: targetDate, toGranularity: .day)
        if result == .orderedSame {
            return true
        }
        return false
    }
    func addTime(time: String) -> Date {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let overallStr = "\(self.dateOnlyStr) \(time)"
        return format.date(from: overallStr)!
    }
}
