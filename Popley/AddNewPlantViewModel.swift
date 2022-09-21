//
//  AddNewPlantViewModel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import Foundation
import UIKit

@MainActor
class AddNewPlantViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var source: Picker.Source = .library
    @Published var isPickerShown = false
    
    @Published var navigationStack: [Page] = []
    
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
    
    func navigateFurther() {
        switch navigationStack.count {
        case 0:
            navigationStack.append(.plantName)
        case 1:
            navigationStack.append(.plantSummary)
        default:
            fatalError("Unexpected navigation error.")
        }
    }
}
