//
//  WateringInterval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

struct WateringInterval {
    var frequency: Int
    var interval: Interval
}

extension WateringInterval {
    static let everyEightDays = WateringInterval(frequency: 8, interval: .day)
    static let everyTwoWeeks = WateringInterval(frequency: 2, interval: .week)
    static let quarterly = WateringInterval(frequency: 3, interval: .month)
}
