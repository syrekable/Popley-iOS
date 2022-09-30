//
//  MockStorage.swift
//  Popley
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation

class MockStorage: KeyValueStorable {
    private var store: [String: Double]
    
    init() {
        store = [:]
    }
    
    func double(forKey key: String) -> Double {
        guard let value = store[key] else { return 0 }
        return value
    }
    
    func set(_ value: Double, forKey key: String) {
        store[key] = value
    }
}

extension MockStorage {
    static func withMorningNotificationHour() -> MockStorage {
        let storage = MockStorage()
        let wateringTime = NotificationSettings
            .TimeOfDay
            .morning
            .asDateComponents
            .asDateWithHoursAndMinutes!
            .timeIntervalSince1970
        let key = AppSettingsViewModel.userDefaultsKeys["time"]!
        storage.set(wateringTime, forKey: key)
        return storage
    }
}
