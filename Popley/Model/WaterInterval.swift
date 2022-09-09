//
//  WateringInterval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

struct WaterInterval {
    var frequency: Int
    var interval: Interval
}

extension WaterInterval {
    static let everyEightDays = WaterInterval(frequency: 8, interval: .day)
    static let everyTwoWeeks = WaterInterval(frequency: 2, interval: .week)
    static let quarterly = WaterInterval(frequency: 3, interval: .month)
}

extension WaterInterval: CustomStringConvertible {
    var description: String {
        let interval = self.frequency > 1 || self.frequency == 0 ? "\(self.interval)s" : self.interval.rawValue
        return "\(self.frequency) \(interval)"
    }
}
