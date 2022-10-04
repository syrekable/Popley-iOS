//
//  WaterIntervalTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 15/09/2022.
//

import XCTest
import Datez
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
        let days = [1, 6, 13, 15]
        let expected = ["1 day", "6 days", "13 days", "15 days"]
        
        for (i, day) in days.enumerated() {
            let interval = WaterInterval(days: day)
            XCTAssertEqual(expected[i], interval?.description)
        }
    }
    
    func testInitializeFromDaysForUpToThreeWholeWeeks() {
        let days = [7, 21]
        let expected = ["1 week", "3 weeks"]
        
        for (i, day) in days.enumerated() {
            let interval = WaterInterval(days: day)
            XCTAssertEqual(expected[i], interval?.description)
        }
    }
    
    func testInitializeFromDaysForMoreThanFiveWeeks() {
        let days = [30, 35, 90]
        let expected = ["1 month", "1 month", "3 months"]
        
        for (i, day) in days.enumerated() {
            let interval = WaterInterval(days: day)
            XCTAssertEqual(expected[i], interval?.description)
        }
    }
    
    func testRestrictingWateringRangeToOneDayLessThanWateringFrequency() {
        let date = Date()
        let waterEvery = 3
        let expected: ClosedRange<Date> = (Date() - (3 - 1).day.timeInterval)...Date()
        
        let range = WaterIntervalPickerViewModel.makeDateRange(from: date, for: waterEvery)
        
        XCTAssertEqual(range.lowerBound.timeIntervalSince1970, expected.lowerBound.timeIntervalSince1970, accuracy: 0.1)
        XCTAssertEqual(range.upperBound.timeIntervalSince1970, expected.upperBound.timeIntervalSince1970, accuracy: 0.1)
    }
    
    func testCryForWater() {
        let lastWaterDate = Date() - 2.day.timeInterval
        let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: lastWaterDate)
        
        XCTAssertEqual(plant.timeToWater.asDescriptiveDateInterval.description, "Today!")
    }
}
