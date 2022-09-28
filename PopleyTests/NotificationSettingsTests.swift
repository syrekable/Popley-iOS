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
}
