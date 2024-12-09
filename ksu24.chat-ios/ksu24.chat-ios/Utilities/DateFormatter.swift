//
//  DateFormatter.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 21/11/2024.
//

import Foundation

extension Date {
    func previewDate() -> String {
        let calendar = Calendar.current
        let now = Date()

        let formatter = DateFormatter()
        formatter.locale = Locale.current

        if calendar.isDateInToday(self) {
            formatter.dateFormat = "HH:mm"
            
            return formatter.string(from: self)
            
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
            
        } else if calendar.isDate(self, equalTo: now, toGranularity: .weekOfYear) {
            formatter.dateFormat = "EEE"
            
            return formatter.string(from: self)
            
        } else {
            formatter.dateFormat = "dd.MM.yyyy"
            
            return formatter.string(from: self)
        }
    }
}

func parseDateString(_ dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
    return formatter.date(from: dateString)
}

func parseDateToString(date: Date) -> String {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return dateFormatter.string(from: date)
}
