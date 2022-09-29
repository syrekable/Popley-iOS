//
//  DateComponents.swift
//  Popley
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation

extension DateComponents {
    // https://stackoverflow.com/a/36082867/12938809 - Date from DateComponents
    // could have probably just used DateComponents.date, but
    // it throws more often than this
    var asDateWithHoursAndMinutes: Date? {
        guard self.hour != nil && self.minute != nil else { return nil }
        return Calendar.current.date(bySettingHour: self.hour!, minute: self.minute!, second: 0, of: Date())!
    }
}

extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        print(lhs.description, rhs.description)
        let _a =  lhs.hour! < rhs.hour! || lhs.minute! < rhs.minute!
        return _a
    }
}
