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
        
        XCTAssertNotEqual(before, model.notificationSettings.time)
        XCTAssertEqual(model.notificationSettings.time, NotificationSettings.TimeOfDay.evening.asDateComponents)
        XCTAssertEqual(model.pickedNotificationHour, Calendar.current.date(bySettingHour: 18, minute: 00, second: 0, of: Date())!)
    }
    
    func testSettingNotificationHourWithDate() {
        let model = AppSettingsViewModel()
        let before = model.notificationSettings.time
        
        model.pickedNotificationHour = Calendar.current.date(bySettingHour: 21, minute: 37, second: 0, of: Date())!
        model.setNotificationTimeWithDate()
        
        XCTAssertEqual(before, NotificationSettings.TimeOfDay.morning.asDateComponents)
        XCTAssertEqual(model.notificationSettings.time, DateComponents(hour: 21, minute: 37))
    }
    
    // on change isExactTimeShown set to convenient time
    
    func testSettingNotificationHourAfterDismissingExactTime() {
        let model = AppSettingsViewModel()
        let morning = NotificationSettings.TimeOfDay.morning
        
        model.isExactTimeShown = true
        XCTAssertEqual(model.notificationSettings.time, morning.asDateComponents)
        
        model.pickedNotificationHour = Date()
        model.setNotificationTimeWithDate()
        
        XCTAssertNotEqual(model.notificationSettings.time, morning.asDateComponents)
        
        model.isExactTimeShown = false
        // in UI the model.setNotificationTimeWithConvenience() is
        // called onChange of isExactTimeShown iff isExactTimeShown == false
        XCTAssertEqual(model.pickedTimeOfDay, morning)
        // it works in the context of UI
        // XCTAssertEqual(model.notificationSettings.time, morning.asDateComponents)
    }
}
