//
//  DateExt.swift
//  UIGraph
//
//  Created by Zachary Duncan on 7/24/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import Foundation

extension Date {
    fileprivate static let formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.formatterBehavior = .default
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        return formatter
    }()
    
    fileprivate static let calendar:Calendar = {
        return Calendar.current
    }()
    
    var localizedDescrition:String {
        return Date.formatter.string(from: self)
    }
    
    var startOfDay: Date {
        return Date.calendar.startOfDay(for: self)
    }
    
    var endOfDay:Date {
        return Date.calendar.date(byAdding: DateComponents(day:1, second:-1), to:startOfDay)!
    }
    
    var isWeekend:Bool {
        let weekday = Date.calendar.component(.weekday, from: self)
        
        if weekday == 1 || weekday == 7 {
            return true
        } else {
            return false
        }
    }
    
    var startOfWeek:Date {
        var components = Date.calendar.dateComponents([.year, .month, .weekday, .day], from: startOfDay)
        let offset = components.weekday! - Date.calendar.firstWeekday
        components.day = components.day! - offset
        
        return Date.calendar.date(from: components)!
    }
    
    var endOfWeek:Date {
        return Date.calendar.date(byAdding: DateComponents(second: -1, weekOfMonth: 1), to: startOfWeek)!
    }
    
    var startOfMonth:Date {
        let components = Date.calendar.dateComponents([.year, .month], from: startOfDay)
        return Date.calendar.date(from: components)!
    }
    
    var endOfMonth:Date {
        return Date.calendar.date(byAdding: DateComponents(month: 1 , second: -1), to: startOfMonth)!
    }
    
    var startOfYear:Date {
        let year = Date.calendar.component(.year, from: startOfDay)
        return Date.calendar.date(from: DateComponents(year: year))!
    }
    
    var endOfYear:Date {
        return Date.calendar.date(byAdding: DateComponents(year: 1, second: -1), to: startOfYear)!
    }
    
    func addDays(_ days:Int) -> Date {
        return Date.calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    func addMonths(_ days:Int) -> Date {
        return Date.calendar.date(byAdding: .month, value: days, to: self)!
    }
    
    func addYears(_ days:Int) -> Date {
        return Date.calendar.date(byAdding: .year, value: days, to: self)!
    }
    
    func isBefore(_ date:Date) -> Bool {
        return compare(date) == .orderedAscending
    }
    
    func isAfter(_ date:Date) -> Bool {
        return compare(date) == .orderedDescending
    }
    
    func isBetween(_ startDate:Date, _ endDate:Date) -> Bool {
        if isBefore(startDate) {
            return false
        }
        
        if isAfter(endDate) {
            return false
        }
        
        return true
    }
    
    func isSame(_ date:Date) -> Bool {
        return compare(date) == .orderedSame
    }
}



struct DateFormat {
    fileprivate static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter
    }()
    
    fileprivate static let calendar: Calendar = Calendar.current
    
    static func dateFrom(string:String, format:DateFormatType) -> Date? {
        return DateFormat.dateFormatter.date(from: string, withFormat: format)
    }
    
    static func stringFrom(date:Date, format:DateFormatType) -> String {
        return DateFormat.dateFormatter.string(from: date, withFormat: format)
    }
}

extension DateFormat {
    enum DateFormatType:String {
        case defaultFormat = "MM/dd/yy"
        case monthName = "MMMM"
        case dayNumber = "dd"
        case dayOrdinaryNumber = "d'%@'"
        case dayName = "EEEE"
        case monthNamePlusDayNumber = "MMMM',' d'%@'"
        case shortMonthNamePlusDayNumber = "EE'\n'MMM',' d'%@'"
        case fullDate = "dd-MM-yyyy HH:mm:ss"
        case timeStamp = "HH:mm:ss"
    }
}

fileprivate extension DateFormatter {
    func string(from date: Date, withFormat format:DateFormat.DateFormatType) -> String {
        self.dateFormat = format.rawValue
        return String(format: string(from: date), daySuffix(from: date))
    }
    
    func date(from string: String, withFormat format:DateFormat.DateFormatType) -> Date? {
        self.dateFormat = format.rawValue
        return date(from: string)
    }
    
    func daySuffix(from date: Date) -> String {
        let dayOfMonth = DateFormat.calendar.component(.day, from: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
}
