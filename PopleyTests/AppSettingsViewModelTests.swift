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
    
    /*
     to actually test the userdefaults with dependency injection
     https://codereview.stackexchange.com/a/153240
     * methods I need:
        - double(forKey: String) -> Double
        - set(Double, forKey: String)
     */
    
    func testSettingInitialNotificationsTime() {
        let storage = MockStorage()
        let model = AppSettingsViewModel(readFrom: storage)
        let morning: NotificationSettings.TimeOfDay = .morning // convenience
        
        let expected = (
            morning,
            morning.asDateComponents.asDate!,
            NotificationSettings(time: morning.asDateComponents),
            false
        )
        
        XCTAssertEqual(model.pickedTimeOfDay, expected.0)
        XCTAssertEqual(model.pickedNotificationHour, expected.1)
        XCTAssertEqual(model.notificationSettings.time, expected.2.time)
        XCTAssertEqual(model.isExactTimeShown, expected.3)
    }
    
    func testReadingConvenienceStoredAsNotificationsTime() {
        let storage = MockStorage()
        var model: AppSettingsViewModel? = AppSettingsViewModel(readFrom: storage)
        
        let evening: NotificationSettings.TimeOfDay = .evening
        model!.pickedTimeOfDay = evening
        model!.setNotificationTimeWithConvenience()
        
        // deinitializing
        model = nil
        
        model = AppSettingsViewModel(readFrom: storage)
        
        let expected = (
            NotificationSettings(time: evening.asDateComponents),
            evening,
            evening.asDateComponents.asDate!,
            false
        )
        
        XCTAssertEqual(model!.notificationSettings.time, expected.0.time)
        XCTAssertEqual(model!.pickedTimeOfDay, expected.1)
        XCTAssertEqual(model!.pickedNotificationHour, expected.2)
        XCTAssertEqual(model!.isExactTimeShown, expected.3)
    }
}
