//
//  AddNewPlantViewModel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import Foundation
import UIKit

@MainActor
class AddPlantViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var source: Picker.Source = .library
    @Published var isPickerShown = false
    // TODO: propose systematic name from Plant.id rest API
    @Published var plantName = ""
    
    func createPlant() -> Plant {
        return Plant(name: plantName, picture: image!, waterInterval: WaterInterval())
    }
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
            }
            isPickerShown = true
        } catch {
            /*
             isCameraAlertShown = true
             cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
             */
            print(error.localizedDescription)
        }
    }
}
