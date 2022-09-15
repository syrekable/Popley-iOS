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
        let secondsInHour = 3600
        let intervals = [
            DescriptiveDateInterval(frequency: 3, interval: .day),
            DescriptiveDateInterval(frequency: 2, interval: .week),
            DescriptiveDateInterval(frequency: 1, interval: .month)
        ]
        let answers: [Double] = [
            3 * 24 * secondsInHour,
            2 * 7 * 24 * secondsInHour,
            30 * 24 * secondsInHour,
        ].map { Double($0) }
        
        for (i, interval) in intervals.enumerated() {
            XCTAssertEqual(interval.asTimeInterval, answers[i], "failed for \(interval)")
            
        }
    }
}
