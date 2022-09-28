//
//  AppSettingsViewModel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 28/09/2022.
//

import Foundation

// TODO: test it!
class AppSettingsViewModel: ObservableObject {
    @Published var timeOfDay: NotificationSettings.TimeOfDay
    @Published var notificationSettings: NotificationSettings
    @Published var isExactTimeShown = false
    // TODO: get rid of this somehow?
    // workaround for DatePicker
    @Published var notificationDate: Date
    
    init() {
        let morning: NotificationSettings.TimeOfDay = .morning
        timeOfDay = morning
        // https://stackoverflow.com/a/36082867/12938809
        notificationDate = Calendar.current.date(bySettingHour: morning.asDateComponents.hour!, minute: morning.asDateComponents.minute!, second: 0, of: Date())!
        // TODO: read from UserDefaults/AppStorage
        notificationSettings = NotificationSettings(time: morning.asDateComponents)
    }
    
    // TODO: refactor
    func setNotificationTimeWithConvenience() {
        notificationSettings.time = timeOfDay.asDateComponents
    }
    
    func setNotificationTimeWithDate() {
        /*
         https://stackoverflow.com/a/62441255/12938809
         var notifTime: Date
         let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: notifTime)
         let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
         */
        notificationSettings.time = Calendar.current.dateComponents([.hour, .minute], from: notificationDate)
    }
}
