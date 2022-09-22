//
//  WateringInterval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

// DateComponentsFormatter was the answer all along lmao
typealias WaterInterval = DescriptiveDateInterval

struct DescriptiveDateInterval: Hashable {
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
    
    init(frequency: Int = 1, interval: Interval = .day) {
        self.frequency = frequency
        self.interval = interval
    }
}

extension DescriptiveDateInterval {
    static let everyEightDays = DescriptiveDateInterval(frequency: 8, interval: .day)
    static let everyTwoWeeks = DescriptiveDateInterval(frequency: 2, interval: .week)
    static let quarterly = DescriptiveDateInterval(frequency: 3, interval: .month)
}

// Due to DateInterval already having this extension,
// which is not overridable,
// I resort to creating this type in order to have human-readable interval information
extension DescriptiveDateInterval: CustomStringConvertible {
    var description: String {
        let interval = self.frequency > 1 || self.frequency == 0 ? "\(self.interval)s" : self.interval.rawValue
        return "\(self.frequency) \(interval)"
    }
}
