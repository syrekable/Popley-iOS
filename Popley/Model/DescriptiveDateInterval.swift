//
//  WateringInterval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

// Date.RelativeFormatStyle shall do it
/// A type facilitates periodical temporal operations. It's used for convenience when working with anything that requires to be repeated after a certain count of intervals.
///
/// Defaults to 1 day.
typealias WaterInterval = DescriptiveDateInterval

/// A type facilitates periodical temporal operations. It's used for convenience when working with anything that requires to be repeated after a certain count of intervals.
struct DescriptiveDateInterval: Hashable {
    var frequency: Int
    var interval: Interval
    
    /// Defaults to 1 day.
    init(frequency: Int = 1, interval: Interval = .day) {
        self.frequency = frequency
        self.interval = interval
    }
    
    init?(days: Int) {
        guard (days >= 1) else { return nil }
        var _frequency: Int?
        var _interval: Interval?
        switch days {
        // whole months
        case let d where d >= (4 * 7):
            _frequency = Int(d / 4 / 7)
            _interval = .month
        // whole weeks (1 week, 2 weeks, ...)
        case let d where d % 7 == 0:
            _frequency = Int(d / 7)
            _interval = .week
        default:
            _frequency = days
            _interval = .day
        }
        frequency = _frequency!
        interval = _interval!
    }
}

// MARK: sample data
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

// MARK: type conversion
extension DescriptiveDateInterval {
    /// Returns the number of seconds in this interval.
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
