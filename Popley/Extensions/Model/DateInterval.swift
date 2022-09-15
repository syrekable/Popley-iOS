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
        case let x where x >= (4 * 7 * 24):
            frequency = Int(x / 4 / 7 / 24)
            interval = .month
        // it's (a) day(s), not whole weeks
        case let x where (x >= 24) && ((Int(x / 24) % 7) != 0):
            frequency = Int(x / 24)
            interval = .day
        // whole weeks (1 week, 2 weeks, ...)
        case let x where (x >= 24) && ((Int(x / 24) % 7) == 0):
            frequency = Int(x / 24 / 7)
            interval = .week
        default:
            fatalError("Something went terribly wrong")
        }
        return DescriptiveDateInterval(frequency: frequency, interval: interval!)
    }
}
