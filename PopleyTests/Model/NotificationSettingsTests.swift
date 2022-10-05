//
//  NotificationSettingsTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 28/09/2022.
//

import XCTest
@testable import Popley

final class NotificationSettingsTests: XCTestCase {
    func testConvenienceEnumToDateComponents() {
        let expected = [
            DateComponents(hour: 8, minute: 00),
            DateComponents(hour: 18, minute: 00)
        ]
        for (i, timeOfDay) in NotificationSettings.TimeOfDay.allCases.enumerated() {
            XCTAssertEqual(timeOfDay.asDateComponents, expected[i])
        }
    }
    
    func testPickingAppropriateEnumForMorningHours() {
        // 'morning' definition - https://dictionary.cambridge.org/dictionary/english/morning
        let morningHours = [
            DateComponents(hour: 0, minute: 0),
            DateComponents(hour: 0, minute: 1),
            DateComponents(hour: 6, minute: 30),
            DateComponents(hour: 07, minute: 30),
            NotificationSettings.TimeOfDay.morning.asDateComponents,
            DateComponents(hour: 10, minute: 0),
            DateComponents(hour: 10, minute: 1),
            DateComponents(hour: 14, minute: 59),
            DateComponents(hour: 15, minute: 00)
            ]
        let expected: NotificationSettings.TimeOfDay = .morning
        
        // something is wrong with checking the hours containing minutes != 0
        for hour in morningHours {
            let timeOfDay = NotificationSettings.TimeOfDay.appropriateTimeOfDay(for: hour)
            XCTAssertEqual(timeOfDay, expected, "failed for \(hour)")
        }
    }
    
    func testPickingAppropriateEnumForEveningHours() {
        // more arbitrarily here
        let eveningHours = [
            DateComponents(hour: 15, minute: 01),
            DateComponents(hour: 16, minute: 0),
            NotificationSettings.TimeOfDay.evening.asDateComponents,
            DateComponents(hour: 23, minute: 59)
            ]
        let expected: NotificationSettings.TimeOfDay = .evening
        
        for hour in eveningHours {
            let timeOfDay = NotificationSettings.TimeOfDay.appropriateTimeOfDay(for: hour)
            XCTAssertEqual(timeOfDay, expected)
        }
    }
    
    func testCheckingIfTheTimeIsExactlyMorning() {
        let morningHours = [
            DateComponents(hour: 6, minute: 30),
            NotificationSettings.TimeOfDay.morning.asDateComponents,
            DateComponents(hour: 15, minute: 00)
            ]
        let expected = [
            false,
            true,
            false
        ]
        
        for (i, hour) in morningHours.enumerated() {
            let status = NotificationSettings.TimeOfDay.isExact(hour: hour)
            XCTAssertEqual(status, expected[i])
        }
    }
    
    func testCheckingIfTheTimeIsExactlyEvening() {
        let eveningHours = [
            DateComponents(hour: 15, minute: 01),
            NotificationSettings.TimeOfDay.evening.asDateComponents,
            DateComponents(hour: 23, minute: 59)
            ]
        let expected = [
            false,
            true,
            false
        ]
        
        for (i, hour) in eveningHours.enumerated() {
            let status = NotificationSettings.TimeOfDay.isExact(hour: hour)
            XCTAssertEqual(status, expected[i])
        }
    }
}
