//
//  DateInterval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 15/09/2022.
//

import Foundation

extension DateInterval {
    var asDescriptiveDateInterval: DescriptiveDateInterval {
        let hoursInInterval = ceil(self.duration / 3600)
        var frequency: Int = 0
        var interval: Interval?
        switch hoursInInterval {
        // today
        case 0..<24:
            frequency = 0
            interval = .day
        // months
        case let h where h >= (4 * 7 * 24):
            frequency = Int(h / 4 / 7 / 24)
            interval = .month
        // it's (a) day(s), not whole weeks
        case let h where (h >= 24) && ((Int(h / 24) % 7) != 0):
            frequency = Int(h / 24)
            interval = .day
        // whole weeks (1 week, 2 weeks, ...)
        case let h where (h >= 24) && ((Int(h / 24) % 7) == 0):
            frequency = Int(h / 24 / 7)
            interval = .week
        default:
            fatalError("Something went terribly wrong")
        }
        return DescriptiveDateInterval(frequency: frequency, interval: interval!)
    }
}
