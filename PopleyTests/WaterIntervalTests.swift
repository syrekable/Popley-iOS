//
//  WaterIntervalTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 15/09/2022.
//

import XCTest
@testable import Popley

final class WaterIntervalTests: XCTestCase {
    // MARK: works under the assumption that each month = 30 days
    func testConversionToTimeInterval() {
        let secondsInHour = 60 * 60
        let intervals = [
            WaterInterval(frequency: 3, interval: .day),
            WaterInterval(frequency: 2, interval: .week),
            WaterInterval(frequency: 1, interval: .month)
        ]
        let expected: [Double] = [
            3 * 24 * secondsInHour,
            2 * 7 * 24 * secondsInHour,
            30 * 24 * secondsInHour,
        ].map { Double($0) }
        
        for (i, interval) in intervals.enumerated() {
            XCTAssertEqual(interval.asTimeInterval, expected[i], "failed for \(interval)")
            
        }
    }
    
    func testInitializeFromDaysForDays() {
        let days = [1,6,13,15]
        let expected = ["1 day", "6 days", "13 days", "15 days"]
        
        for (i, day) in days.enumerated() {
            let interval = WaterInterval(days: day)
            XCTAssertEqual(expected[i], interval?.description)
        }
    }
}
