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
    
    private static let userDefaultsKeys: [String: String] = ["time": "NOTIFICATION_TIME"]
    
    init() {
        let timeInterval: TimeInterval = UserDefaults.standard.double(forKey: Self.userDefaultsKeys["time"]!)
        if timeInterval > 0 {
            // succesfully read from UserDefaults
            let date = Date(timeIntervalSince1970: timeInterval)
            let settings = NotificationSettings(time: date.asDateComponents)
            notificationSettings = settings
            // TODO: set according to which one is closer, i.e. has smaller distance to the notificationSettings.time
            pickedTimeOfDay = .morning
            // TODO: iff notificationSettings.time is not contained in [.morning, .evening]
            isExactTimeShown = true
            pickedNotificationHour = settings.time.asDate!
        } else {
            // first time in app (settings) or something broke
            let morning: NotificationSettings.TimeOfDay = .morning
            pickedTimeOfDay = morning
            pickedNotificationHour = morning.asDateComponents.asDate!
            notificationSettings = NotificationSettings(time: morning.asDateComponents)
            isExactTimeShown = false
        }
    }
    
    // TODO: DRY those up
    func setNotificationTimeWithConvenience() {
        notificationSettings.time = pickedTimeOfDay.asDateComponents
        pickedNotificationHour = pickedTimeOfDay.asDateComponents.asDate!
    }
    
    func setNotificationTimeWithDate() {
        notificationSettings.time = pickedNotificationHour.asDateComponents
    }
    
    /*
     https://stackoverflow.com/a/63019446/12938809
     // save
     UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: key)

     // read
     let date = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: key))
     */
    func save(to storage: KeyValueStorable = UserDefaults.standard) {
        storage.set(notificationSettings.time.asDate!.timeIntervalSince1970, forKey: Self.userDefaultsKeys["time"]!)
    }
}
