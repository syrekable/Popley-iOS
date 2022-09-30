//
//  Model.swift
//  Popley
//
//  Created by Jordan Niedzielski on 17/09/2022.
//

import Foundation
import SwiftUI

//@MainActor
class Model: ObservableObject {
    @Published var path = NavigationPath()
    
    @Published var plants: [Plant] = Plant.sampleData
    
    @Published var isCameraAvailable = false
    @Published var isCameraAlertShown = false
    @Published var cameraError: ImageSourcePicker.CameraErrorType?
    
    private var storage: KeyValueStorable
    
    init(readFrom storage: KeyValueStorable = UserDefaults.standard) {
        self.storage = storage
    }
}

// MARK: navigation
extension Model {
    func navigateToPlant(_ plant: Plant) {
        path.append(plant)
    }
    
    func navigateToPage(_ page: Page) {
        path.append(page)
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}

// MARK: plants
extension Model {
    func createPlant(named name: String, withPicture picture: UIImage, wateredEvery days: Int, lastWatered date: Date) -> Plant {
        let interval = WaterInterval(days: days)!
        let plant = Plant(name: name, picture: picture, waterInterval: interval, lastWaterDate: date)
        return plant
    }
    
    // TODO: completion handle if scheduling notification fails
    /// Adds a new `plant` to the user's collection, optionally scheduling notification for watering if none is set for `plant.TimeToWater`.
    func addPlant(_ plant: Plant, notificationManager manager: NotificationManaging = UNUserNotificationCenter.current()) {
        let request = makeRequest(for: plant)
        manager.add(request, withCompletionHandler: nil)
        plants.append(plant)
    }
}

// MARK: notifications
extension Model {
    private func makeRequest(for plant: Plant) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()

        let notificationTime: DateComponents = Date(
            timeIntervalSince1970: storage
                .double(
                    forKey:
                        AppSettingsViewModel.userDefaultsKeys["time"]!
                )).asDateComponents
        let triggerTime = DateComponents(
            day: Date().distance(to: plant.timeToWater.end).totalDays,
            hour: notificationTime.hour,
            minute: notificationTime.minute
        )
        
        /*
         DateComponents(
             day: Date().distance(to: plant.timeToWater.end),
             hour: notificationTime.hour,
             minute: notificationTime.minute)
         */
        
        // DateInterval.end -> plant.timeToWater.end
        // Date.distance(to: ) -> Date().distance(to: plant.timeToWater.end)
        // notificationTime = Date(timeIntervalSince1970: storage.double(forKey: Self.userDefaultsKeys["time"]!)).asDateComponents!
        // DateComponents(day: Date().distance(to: plant.timeToWater.end), hour: notificationTime.hour, minute: notificationTime.minute)
        /*
         let timeInterval: TimeInterval = storage.double(forKey: Self.userDefaultsKeys["time"]!)
         if timeInterval > 0 {
             // succesfully read from UserDefaults
             let date = Date(timeIntervalSince1970: timeInterval)
             let settings = NotificationSettings(time: date.asDateComponents)
         */
        
        let trigger: UNCalendarNotificationTrigger? =
        UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: false)
        
        return UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
    }
}

// MARK: camera usage
extension Model {
    // adopted from Steward Lynch's 'My Images' app
    // https://youtu.be/yMC16EZHwZU
    func useDeviceCamera() {
        do {
            try ImageSourcePicker.checkPermissions()
            isCameraAvailable = true
        } catch {
            isCameraAlertShown = true
            cameraError = ImageSourcePicker.CameraErrorType(error: error as! ImageSourcePicker.PickerError)
        }
    }
}
