//
//  Picker.swift
//  My Images
//
//  Created by Jordan Niedzielski on 19/09/2022.
//

import SwiftUI
import AVFoundation

enum Picker {
    enum Source {
        case camera, library
    }
    
    enum PickerError: Error, LocalizedError {
        case unavailable, restricted, denied
        
        var errorDescription: String? {
            switch self {
            case .unavailable:
                return NSLocalizedString("There is no camera on the device.", comment: "")
            case .restricted:
                return NSLocalizedString("You're not allowed to access media apture devices.", comment: "")
            case .denied:
                return NSLocalizedString("You have explicitly denied permission for media capture. Please open permissions/Privacy/Camera and grant access to this application.", comment: "")
            }
        }
    }
    
    static func checkPermissions() throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch authStatus {
            case .restricted:
                throw PickerError.restricted
            case .denied:
                throw PickerError.denied
            default:
                break
            }
        } else {
            throw PickerError.unavailable
        }
    }
    
    struct CameraErrorType {
        let error: PickerError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}
