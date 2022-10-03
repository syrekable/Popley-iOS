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
    
    @Published var isNotificationAuthorized = false
    
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
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            // TODO: bądźmy łagodni
            if let error = error {
                fatalError(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.isNotificationAuthorized = granted
            }
        }
    }
    
    // TODO: refactor as in https://betterprogramming.pub/implementing-clean-mvvm-with-swiftui-10c52d503d67
    func refreshAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isNotificationAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    private func makeRequest(for plant: Plant) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Popley"
        content.subtitle = "Your plants are thirsty!"
        content.body = "At least one of your plants needs water. Open Popley to find out, which!"

        let storedNotificationTime: TimeInterval =  storage
                .double(
                    forKey:
                        AppSettingsViewModel.userDefaultsKeys["time"]!
                )
        
        // desperation over declarativeness
        let triggerTime =  Date().distance(to: plant.timeToWater.end) + storedNotificationTime - Date().timeIntervalSince1970
        
        print("Trigger time in Model: \(triggerTime)")

        let trigger: UNTimeIntervalNotificationTrigger? = UNTimeIntervalNotificationTrigger(timeInterval: triggerTime, repeats: false)
        
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
