//
//  TypeDescriptionTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

import XCTest
@testable import Popley

final class TypeDescriptionTests: XCTestCase {
    func testWaterIntervalSingularDescription() {
        let interval = DescriptiveDateInterval(frequency: 1, interval: .month)
        
        XCTAssertEqual(String(describing: interval), "1 month")
    }
    
    func testWaterIntervalPluralDescription() {
        let interval = DescriptiveDateInterval(frequency: 2, interval: .week)
        
        XCTAssertEqual(String(describing: interval), "2 weeks")
    }
    
    func testConvenienceEnumDescription() {
        let expected = ["Morning", "Evening"]
        for (i, timeOfDay) in NotificationSettings.TimeOfNotification.allCases.enumerated() {
            XCTAssertEqual(String(describing: timeOfDay), expected[i])
        }
    }
}
