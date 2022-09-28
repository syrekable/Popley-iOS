//
//  AppSettingsViewModelTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 28/09/2022.
//

import XCTest
@testable import Popley

final class AppSettingsViewModelTests: XCTestCase {
    func testSettingNotificationHourWithConvenience() {
        let model = AppSettingsViewModel()
        let before = model.notificationSettings.time
        
        model.pickedTimeOfDay = .evening
        model.setNotificationTimeWithConvenience()
        
        XCTAssertEqual(NotificationSettings.TimeOfDay.morning.asDateComponents, before)
        XCTAssertEqual(NotificationSettings.TimeOfDay.evening.asDateComponents, model.notificationSettings.time)
        XCTAssertEqual(model.notificationDate, Calendar.current.date(bySettingHour: 18, minute: 00, second: 0, of: Date())!)
    }
    
    func testSettingNotificationHourWithDate() {
        let model = AppSettingsViewModel()
        let before = model.notificationSettings.time
        
        model.notificationDate = Calendar.current.date(bySettingHour: 21, minute: 37, second: 0, of: Date())!
        model.setNotificationTimeWithDate()
        
        XCTAssertEqual(before, NotificationSettings.TimeOfDay.morning.asDateComponents)
        XCTAssertEqual(model.notificationSettings.time, DateComponents(hour: 21, minute: 37))
    }
}
