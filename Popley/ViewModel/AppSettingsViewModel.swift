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
        notificationDate = morning.asDateComponents.asDate!
        // TODO: read from UserDefaults/AppStorage
        notificationSettings = NotificationSettings(time: morning.asDateComponents)
    }
    
    // TODO: DRY it up
    func setNotificationTimeWithConvenience() {
        notificationSettings.time = pickedTimeOfDay.asDateComponents
        notificationDate = pickedTimeOfDay.asDateComponents.asDate!
    }
    
    func setNotificationTimeWithDate() {
        notificationSettings.time = notificationDate.asDateComponents
    }
}
