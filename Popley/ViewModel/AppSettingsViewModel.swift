//
//  AppSettingsViewModel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 28/09/2022.
//

import Foundation

class AppSettingsViewModel: ObservableObject {
    @Published var notificationSettings: NotificationSettings
    
    @Published var pickedTimeOfDay: NotificationSettings.TimeOfDay
    @Published var pickedNotificationHour: Date
    
    // TODO: computed properrty { get set }
    @Published var isExactTimeShown: Bool
    
    private var storage: KeyValueStorable
    
    
    init(readFrom storage: KeyValueStorable = UserDefaults.standard) {
        // depencendy injection gone wild
        self.storage = storage
        storage.set(true, forKey: AppSettingsViewModel.userDefaultsKeys["launched-before"]!)
        
        let timeInterval: TimeInterval = storage.double(forKey: Self.userDefaultsKeys["time"]!)
        if timeInterval > 0 {
            // succesfully read from UserDefaults
            let date = Date(timeIntervalSince1970: timeInterval)
            let settings = NotificationSettings(time: date.asDateComponents)

            notificationSettings = settings
            pickedTimeOfDay = NotificationSettings.TimeOfDay.appropriateTimeOfDay(for: settings.time)
            isExactTimeShown = !NotificationSettings.TimeOfDay.isExact(hour: settings.time)
            pickedNotificationHour =  settings.time.asDateWithHoursAndMinutes!
        } else {
            // first time in app (settings) or something broke
            let morning: NotificationSettings.TimeOfDay = .morning
            pickedTimeOfDay = morning
            pickedNotificationHour = morning.asDateComponents.asDateWithHoursAndMinutes!
            notificationSettings = NotificationSettings(time: morning.asDateComponents)
            isExactTimeShown = false
        }
    }
    
    deinit {
        save(to: storage)
    }
}

// MARK: userDefaultsKeys
extension AppSettingsViewModel {
    static let userDefaultsKeys: [String: String] = [
        "time": "NOTIFICATION_TIME",
        "launched-before": "LAUNCHED_BEFORE"
    ]
}

// MARK: set notification time
extension AppSettingsViewModel {
    // TODO: DRY those up
    func setNotificationTimeWithConvenience() {
        notificationSettings.time = pickedTimeOfDay.asDateComponents
        pickedNotificationHour = pickedTimeOfDay.asDateComponents.asDateWithHoursAndMinutes!
    }
    
    func setNotificationTimeWithDate() {
        notificationSettings.time = pickedNotificationHour.asDateComponents
    }
}

// MARK: persistence
extension AppSettingsViewModel {
//     https://stackoverflow.com/a/63019446/12938809
    func save(to storage: KeyValueStorable = UserDefaults.standard) {
        storage.set(notificationSettings.time.asDateWithHoursAndMinutes!.timeIntervalSince1970, forKey: Self.userDefaultsKeys["time"]!)
    }
}
