//
//  AppSettingsView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 28/09/2022.
//

import SwiftUI

struct AppSettingsView: View {
    @StateObject var appSettingsViewModel = AppSettingsViewModel()
    
    var body: some View {
        Form {
            notificationDelivery
            advanced
        }
        .onChange(of: appSettingsViewModel.pickedTimeOfDay, perform: { newValue in
            appSettingsViewModel.setNotificationTimeWithConvenience()
        })
        .navigationTitle("Settings")
    }
}

extension AppSettingsView {
    var notificationDelivery: some View {
        Section {
            Picker("Time of notification", selection: $appSettingsViewModel.pickedTimeOfDay) {
                ForEach(NotificationSettings.TimeOfDay.allCases) { timeOfDay in
                    Text(String(describing: timeOfDay))
                }
            }
            .disabled(appSettingsViewModel.isExactTimeShown)
        } header: {
            Text("Notification delivery")
        } footer: {
            VStack(alignment: .leading, spacing: 5) {
                Text("Conveniently set the preffered reminder delivery time.")
                Text("Morning defaults to an hour before Work focus is enabled. Evening defaults to an hour after Work focus is enabled.")
                Text("In case Work focus mode is not set up on a periodic basis, Morning defaults to 8 AM and Evening defaults to 6 PM.")
            }
        }
    }
    var advanced: some View {
        Section {
            Toggle("Remind at a different time", isOn: $appSettingsViewModel.isExactTimeShown)
                .onChange(of: appSettingsViewModel.isExactTimeShown) { newValue in
                    if !newValue {
                        appSettingsViewModel.setNotificationTimeWithConvenience()
                    }
                }
            if appSettingsViewModel.isExactTimeShown {
                DatePicker(selection: $appSettingsViewModel.notificationDate, displayedComponents: .hourAndMinute) {
                    Text("Notification time")
                }
                .onChange(of: appSettingsViewModel.notificationDate) { newValue in
                    appSettingsViewModel.setNotificationTimeWithDate()
                }
            }
        } header: {
            Text("Advanced")
        } footer: {
            if !appSettingsViewModel.isExactTimeShown {
                Text("Set precise time for the reminder delivery.")
            }
        }
    }
}

struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppSettingsView()
        }
    }
}
