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
        let storage = MockStorage()
        let model = AppSettingsViewModel(readFrom: storage)
        let before = model.notificationSettings.time
        
        model.pickedTimeOfDay = .evening
        model.setNotificationTimeWithConvenience()
        
        XCTAssertNotEqual(before, model.notificationSettings.time)
        XCTAssertEqual(model.notificationSettings.time, NotificationSettings.TimeOfDay.evening.asDateComponents)
        XCTAssertEqual(model.pickedNotificationHour, Calendar.current.date(bySettingHour: 18, minute: 00, second: 0, of: Date())!)
    }
    
    func testSettingNotificationHourWithDate() {
        let storage = MockStorage()
        let model = AppSettingsViewModel(readFrom: storage)
        let before = model.notificationSettings.time
        
        model.pickedNotificationHour = Calendar.current.date(bySettingHour: 21, minute: 37, second: 0, of: Date())!
        model.setNotificationTimeWithDate()
        
        XCTAssertEqual(before, NotificationSettings.TimeOfDay.morning.asDateComponents)
        XCTAssertEqual(model.notificationSettings.time, DateComponents(hour: 21, minute: 37))
    }
    
    func testSettingNotificationHourAfterDismissingExactTime() {
        let storage = MockStorage()
        let model = AppSettingsViewModel(readFrom: storage)
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
            morning.asDateComponents.asDateWithHoursAndMinutes!,
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
        // picked evening from picker
        model!.pickedTimeOfDay = evening
        model!.setNotificationTimeWithConvenience()
        
        // deinitializing
        model = nil
        
        model = AppSettingsViewModel(readFrom: storage)
        
        let expected = (
            NotificationSettings(time: evening.asDateComponents),
            evening,
            evening.asDateComponents.asDateWithHoursAndMinutes,
            false
        )
        
        XCTAssertEqual(model!.notificationSettings.time, expected.0.time)
        XCTAssertEqual(model!.pickedTimeOfDay, expected.1)
        XCTAssertEqual(model!.pickedNotificationHour, expected.2)
        XCTAssertEqual(model!.isExactTimeShown, expected.3)
    }
    
    func testReadingDifferentHourAsNotificationsTime() {
        let storage = MockStorage()
        var model: AppSettingsViewModel? = AppSettingsViewModel(readFrom: storage)
        
        let morningTime = DateComponents(hour: 07, minute: 30)
        
        // clicked the button
        model!.isExactTimeShown = true
        // picked time
        model!.pickedNotificationHour = morningTime.asDateWithHoursAndMinutes!
        model!.setNotificationTimeWithDate()
        
        // deinitializing
        model = nil
        
        model = AppSettingsViewModel(readFrom: storage)
        
        let expected = (
            NotificationSettings(time: morningTime),
            NotificationSettings.TimeOfDay.morning,
            morningTime.asDateWithHoursAndMinutes!,
            true
        )
        
        XCTAssertEqual(model!.notificationSettings.time, expected.0.time)
        XCTAssertEqual(model!.pickedTimeOfDay, expected.1)
        XCTAssertEqual(model!.pickedNotificationHour, expected.2)
        XCTAssertEqual(model!.isExactTimeShown, expected.3)
    }
    
    // TODO: test saving before quitting
}
