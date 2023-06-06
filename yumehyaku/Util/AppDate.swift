//
//  Date.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/06/05.
//

import UIKit
import SwiftDate

class AppDate: NSObject {
    let timeZone = TimeZone(identifier: "Asia/Tokyo")!
    
    func lastGetDate(date: Date) -> Date {
        return (date - (24.hours))
    }
    
    func pastWeek(lastGetDate: Date) -> [Date] {
        var dateArray: [Date] = []
        for i in 0..<lastGetDate.weekday {
            dateArray.append((lastGetDate - (i*24).hours))
        }
        return dateArray
    }
    
    func pastMonth(lastGetDate: Date) -> [Date] {
        var dateArray: [Date] = []
        for i in 0..<lastGetDate.day {
            dateArray.append((lastGetDate - (i*24).hours))
        }
        return dateArray
    }
    
    func dateStrOnlyDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: date)
    }
    
    func strDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = timeZone
        if let result = dateFormatter.date(from: date) {
            return result
        } else {
            return Date()
        }
    }
    
    func dateFormatStr() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }
    
    func pickerDateStrOnlyDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter.string(from: date)
    }
    
    func toStringWithCurrentLocale(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: date)
    }
    
    // 受け取った文字列を指定したformatに合わせて、Date型に整形して返す
    func dateFromString(string: String, format: String) -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    
    // 受け取ったDateを指定したformatに合わせて、文字列に整形して返す
    func stringFromDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func dateDate(string: String, format1: String, format2: String) -> String {
        let date1: Date = dateFromString(string: string, format: format1)
        let date2: String = stringFromDate(date: date1, format: format2)
        return date2
    }
    
}

extension Date {
    func toString(dateFormat: String = "yyyy年MM月dd日",
                  locale: String = "en_US_POSIX",
                  timeZone: TimeZone? = TimeZone(identifier: "Asia/Tokyo")) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: locale)
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
