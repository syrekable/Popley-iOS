//
//  AppSettingsViewModel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 28/09/2022.
//

import Foundation

class AppSettingsViewModel: ObservableObject {
    @Published var pickedTimeOfDay: NotificationSettings.TimeOfDay
    @Published var notificationSettings: NotificationSettings
    @Published var isExactTimeShown = false
    // TODO: get rid of this somehow?
    // workaround for DatePicker
    @Published var notificationDate: Date
    
    init() {
        let morning: NotificationSettings.TimeOfDay = .morning
        pickedTimeOfDay = morning
        // https://stackoverflow.com/a/36082867/12938809 - Date from DateComponents
        notificationDate = Calendar.current.date(bySettingHour: morning.asDateComponents.hour!, minute: morning.asDateComponents.minute!, second: 0, of: Date())!
        // TODO: read from UserDefaults/AppStorage
        notificationSettings = NotificationSettings(time: morning.asDateComponents)
    }
    
    // TODO: refactor
    func setNotificationTimeWithConvenience() {
        notificationSettings.time = pickedTimeOfDay.asDateComponents
        notificationDate = Calendar.current.date(bySettingHour: pickedTimeOfDay.asDateComponents.hour!, minute: pickedTimeOfDay.asDateComponents.minute!, second: 0, of: Date())!
    }
    
    func setNotificationTimeWithDate() {
//         https://stackoverflow.com/a/62441255/12938809 - DateComponents from Date
        notificationSettings.time = Calendar.current.dateComponents([.hour, .minute], from: notificationDate)
    }
}
