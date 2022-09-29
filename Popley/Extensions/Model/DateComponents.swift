//
//  DateComponents.swift
//  Popley
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation

extension DateComponents {
    // https://stackoverflow.com/a/36082867/12938809 - Date from DateComponents
    var asDate: Date? {
        guard self.hour != nil && self.minute != nil else { return nil }
        return Calendar.current.date(bySettingHour: self.hour!, minute: self.minute!, second: 0, of: Date())!
    }
}
