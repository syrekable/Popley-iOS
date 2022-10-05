//
//  DateComponentsTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation
import XCTest
@testable import Popley

final class DateComponentsTests: XCTestCase {
    func testDateComponentsWithoutMinutesContainedInRange() {
        let range = DateComponents(hour: 0, minute: 0)...DateComponents(hour: 15, minute: 0)
        let hours = [
            DateComponents(hour: 00, minute: 0),
            DateComponents(hour: 12, minute: 0),
            DateComponents(hour: 15, minute: 0),
        ]
        
        for hour in hours {
            XCTAssert(range.contains(hour))
        }
    }
    
    func testDateComponentsWithMinutesContainedInRange() {
        let range = DateComponents(hour: 0, minute: 0)...DateComponents(hour: 15, minute: 0)
        let hours = [
            DateComponents(hour: 00, minute: 1),
            DateComponents(hour: 12, minute: 30),
            DateComponents(hour: 14, minute: 59),
        ]
        
        // conditions for ClosedRange.contains
        for hour in hours {
            XCTAssert(range.lowerBound < hour)
            XCTAssert(hour < range.upperBound)
            XCTAssertNotEqual(hour, range.lowerBound)
            XCTAssertNotEqual(hour, range.upperBound)
        }
        
        // ClosedRange.contains
        for time in hours {
            XCTAssert(range.contains(time), "failed for \(time.hour!):\(time.minute!)")
        }
    }
    
//    func testComparability() {
//        
//    }
}
