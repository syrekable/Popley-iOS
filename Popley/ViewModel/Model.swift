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
    @Published var path: NavigationPath
    
    @Published var plants = [Plant]()
    @Published var thirstyPlants = [Plant]()
    
    @Published var isCameraAvailable = false
    @Published var isCameraAlertShown = false
    @Published var cameraError: ImageSourcePicker.CameraErrorType?
    
    @Published var isNotificationAuthorized = false
    @Published var isShowingThirstyPlants: Bool = false
    
    private var storage: KeyValueStorable
    // workaround for adopting picture saving logic presented in 'My Images' app series
    private var plantPicture: UIImage?
    private var didLaunchBefore: Bool
    
    init(readFrom storage: KeyValueStorable = UserDefaults.standard) {
        self.storage = storage
        self.didLaunchBefore = storage.bool(forKey: AppSettingsViewModel.userDefaultsKeys["launched-before"]!)
        var _path: NavigationPath?
        if didLaunchBefore {
            _path = NavigationPath()
        } else {
            _path = NavigationPath([Page.appSettings])
        }
        self.path = _path!
        loadMyImagesJSONFile()
        plants += Plant.thirstyPlants
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
        let plant = Plant(name: name, waterInterval: interval, lastWaterDate: date)
        plantPicture = picture
        return plant
    }
    
    // TODO: completion handle if scheduling notification fails
    // TODO: refactor; manager as self.manager
    /// Adds a new `plant` to the user's collection, optionally scheduling notification for watering if none is set for `plant.TimeToWater`.
    func addPlant(_ plant: Plant, notificationManager manager: NotificationManaging = UNUserNotificationCenter.current()) {
        if let image = self.plantPicture {
            do {
                try FileManager().saveImage("\(plant.id)", image: image)
            } catch {
                fatalError("Wzięło i zdechło")
            }
        }
        let request = makeRequest(for: plant)
        manager.add(request, withCompletionHandler: nil)
        plants.append(plant)
        saveMyImagesJSONFile()
    }

    /// A procedure that checks if there are any `plants` with `timeToWater <= 0` and sets `isShowingThirstyPlants`.
    ///
    /// The only reason it exists is that `sheet` needs `Binding<Bool>` instead of `Bool`, which could have been a computed property.
    func checkForThirstyPlants() {
        let _thirstyPlants = plants.filter { plant in
            plant.timeToWater.duration <= 0
        }
        isShowingThirstyPlants = _thirstyPlants.count > 0
        thirstyPlants = _thirstyPlants
    }
    
    /// Resets the last watering time of `plant` and schedules reminder for next watering.
    func water(_ plant: Plant, notificationManager manager: NotificationManaging = UNUserNotificationCenter.current()) {
        var _plant = plant
        _plant.water()
        let request = makeRequest(for: _plant)
        manager.add(request, withCompletionHandler: nil)
        plants.replace([plant], with: [_plant]) // I'm kinda scared
    }
    /*
     // since only @Published properties trigger an update, I cannot use that
     var thirstyPlants: [Plant] {
         return plants.filter { plant in
             plant.timeToWater.duration <= 0
         }
     }
     */
    
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

        let storedNotificationTime: TimeInterval =  storage.double(forKey: AppSettingsViewModel.userDefaultsKeys["time"]!)
        
        // desperation over declarativeness
        let triggerTime =  Date().distance(to: plant.timeToWater.end) + storedNotificationTime - Date().timeIntervalSince1970

        let trigger: UNTimeIntervalNotificationTrigger? = UNTimeIntervalNotificationTrigger(timeInterval: triggerTime, repeats: false)
        
        // TODO: meaningful request id
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

// MARK: states for UI/unit testing
extension Model {
    static func withNotificationsEnabled(readFrom storage: KeyValueStorable = UserDefaults.standard) -> Model {
        let model = Model(readFrom: storage)
        model.isNotificationAuthorized = true
        return model
    }
    static func withThirstyPlants(readFrom storage: KeyValueStorable = UserDefaults.standard) -> Model {
        let model = Model(readFrom: storage)
        model.plants = Plant.thirstyPlants
        model.didLaunchBefore = true
        return model
    }
    static func withWateredPlants(readFrom storage: KeyValueStorable = UserDefaults.standard) -> Model {
        let model = Model(readFrom: storage)
        model.plants = Plant.sampleData
        model.didLaunchBefore = true
        return model
    }
}

// MARK: data persistence
// TODO: show caught read/write errors
extension Model {
    private func saveMyImagesJSONFile() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(plants)
            let jsonString = String(decoding: data, as: UTF8.self)
            do {
                try FileManager().saveDocument(contents: jsonString)
            } catch {
                /*
                 isFileAlertShown = true
                 appError = MyImageError.ErrorType(error: error as! MyImageError)
                 */
                print(error.localizedDescription)
            }
        } catch {
            /*
             isFileAlertShown = true
             appError = MyImageError.ErrorType(error: .encodingError)
             */
            print(error.localizedDescription)
        }
    }
    
    func loadMyImagesJSONFile() {
        do {
            let data = try FileManager().readDocument()
            let decoder = JSONDecoder()
            do {
                plants = try decoder.decode([Plant].self, from: data)
            } catch {
                /*
                 isFileAlertShown = true
                 appError = MyImageError.ErrorType(error: .decodingError)
                 */
            }
        } catch {
            /*
             isFileAlertShown = true
             appError = MyImageError.ErrorType(error: error as! MyImageError)
             */
        }
    }
}
