//
//  MockStorage.swift
//  Popley
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation

class MockStorage: KeyValueStorable {
    private var store: [String: Double] = [:]
    
    func double(forKey key: String) -> Double {
        guard let value = store[key] else { return 0 }
        return value
    }
    
    func set(_ value: Double, forKey key: String) {
        store[key] = value
    }
}

// MARK: sample data
extension MockStorage {
    private static let key = AppSettingsViewModel.userDefaultsKeys["time"]!
    /// A function returning `MockStorage` with notification time set to `NotificationSettings.TimeOfDay.morning`, that is 08:00.
    static func withMorningNotificationTime() -> MockStorage {
        let storage = MockStorage()
        let wateringTime = NotificationSettings
            .TimeOfDay
            .morning
            .asDateComponents
            .asDateWithHoursAndMinutes!
            .timeIntervalSince1970
        storage.set(wateringTime, forKey: key)
        return storage
    }
    
    /// A function returning `MockStorage` with notification time set to 21:37.
    static func withSpecificNotificationTime() -> MockStorage {
        let storage = MockStorage()
        let wateringTime = DateComponents(hour: 21, minute: 37)
            .asDateWithHoursAndMinutes!
            .timeIntervalSince1970
        storage.set(wateringTime, forKey: key)
        return storage
    }
}
