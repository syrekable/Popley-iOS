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
    
    func testPickingAppropriateEnumForMorning() {
        // 'morning' definition - https://dictionary.cambridge.org/dictionary/english/morning
        let morningHours = [
            DateComponents(hour: 6, minute: 30),
            NotificationSettings.TimeOfDay.morning.asDateComponents,
            DateComponents(hour: 15, minute: 00)
            ]
        let expected: NotificationSettings.TimeOfDay = .morning
        
        for hour in morningHours {
            let timeOfDay = NotificationSettings.TimeOfDay.appropriateTimeOfDay(for: hour)
            XCTAssertEqual(timeOfDay, expected)
        }
    }
    
    func testPickingAppropriateEnumForEvening() {
        // more arbitrarily here
        let morningHours = [
            DateComponents(hour: 15, minute: 01),
            NotificationSettings.TimeOfDay.evening.asDateComponents,
            DateComponents(hour: 23, minute: 59)
            ]
        let expected: NotificationSettings.TimeOfDay = .evening
        
        for hour in morningHours {
            let timeOfDay = NotificationSettings.TimeOfDay.appropriateTimeOfDay(for: hour)
            XCTAssertEqual(timeOfDay, expected)
        }
    }
}
