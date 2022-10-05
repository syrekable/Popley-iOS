//
//  DateIntervalTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 15/09/2022.
//

import XCTest
import Datez
@testable import Popley

final class DateIntervalTests: XCTestCase {
    func testDayDateIntervalAsDescriptiveDateInterval() {
        let interval = DateInterval(start: Date(), duration: 1.days.timeInterval)
        
        XCTAssertEqual("1 day",
                       String(describing: interval.asDescriptiveDateInterval))
    }
    
    func testDateIntervalLessThanAWeekAsDescriptiveDateInterval() {
        let interval = DateInterval(start: Date(), duration: 6.days.timeInterval)
        
        XCTAssertEqual("6 days",
                       String(describing: interval.asDescriptiveDateInterval))
    }
    
    func testDateIntervalMoreThanAWeekAsDescriptiveDateInterval() {
        let interval = DateInterval(start: Date(), duration: 8.days.timeInterval)
        
        XCTAssertEqual("8 days",
                       String(describing: interval.asDescriptiveDateInterval))
    }
    
    func testDateIntervalTwoWeeksAsDescriptiveDateInterval() {
        let interval = DateInterval(start: Date(), duration: 14.days.timeInterval)
        
        XCTAssertEqual("2 weeks",
                       String(describing: interval.asDescriptiveDateInterval))
    }
    
    func testDateIntervalThreeMonthsAsDescriptiveDateInterval() {
        let interval = DateInterval(start: Date(), duration: 3.months.timeInterval)
        
        XCTAssertEqual("3 months",
                       String(describing: interval.asDescriptiveDateInterval))
    }
    
    func testDateIntervalFiveWeeksAsAMonth() {
        let interval = DateInterval(start: Date(), duration: 5.weeksOfYear.timeInterval)
        
        XCTAssertEqual("1 month",
                       String(describing: interval.asDescriptiveDateInterval))
    }
    
    func testAssertTypeAliasWorks() {
        let interval = WaterInterval(frequency: 42, interval: .day)
        XCTAssertNotNil(interval)
    }
}
