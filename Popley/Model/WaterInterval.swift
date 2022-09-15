//
//  WateringInterval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

struct WaterInterval: Hashable {
    var frequency: Int
    var interval: Interval
    var asTimeInterval: TimeInterval {
        let secondsInHour = 3600.0
        var hoursInInterval = 0.0
        switch interval {
        case .day:
            hoursInInterval = 24.0
        case .week:
            hoursInInterval = 7 * 24.0
        case .month:
            // FIXME: assumes 30 days in each month
            hoursInInterval = 30 * 24.0
        }
        return Double(frequency) * hoursInInterval * secondsInHour
    }
}

extension WaterInterval {
    static let everyEightDays = WaterInterval(frequency: 8, interval: .day)
    static let everyTwoWeeks = WaterInterval(frequency: 2, interval: .week)
    static let quarterly = WaterInterval(frequency: 3, interval: .month)
}

// Due to DateInterval already having this extension,
// which is not overridable,
// I resort to creating this type in order to have human-readable interval information
extension WaterInterval: CustomStringConvertible {
    var description: String {
        let interval = self.frequency > 1 || self.frequency == 0 ? "\(self.interval)s" : self.interval.rawValue
        return "\(self.frequency) \(interval)"
    }
}
