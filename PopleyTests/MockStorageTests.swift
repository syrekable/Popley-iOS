//
//  MockStorageTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 30/09/2022.
//

import Foundation
import XCTest
@testable import Popley

final class MockStorageTests: XCTestCase {
    func testStorageWithMorningNotificationHour() {
        let key = AppSettingsViewModel.userDefaultsKeys["time"]!
        let wateringTime = NotificationSettings
            .TimeOfDay
            .morning
            .asDateComponents
            .asDateWithHoursAndMinutes!
            .timeIntervalSince1970
        
        let storage = MockStorage.withMorningNotificationTime()
        
        XCTAssertNotNil(storage.double(forKey: key))
        XCTAssertEqual(wateringTime, storage.double(forKey: key))
    }
}
