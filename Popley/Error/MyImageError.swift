//
//  MyImageError.swift
//  Popley
//
//  Created by Jordan Niedzielski on 04/10/2022.
//

import Foundation
import SwiftUI

enum MyImageError: Error, LocalizedError {
    case readError
    case decodingError
    case encodingError
    case saveError
    case saveImageError
    case readImageError
    
    var errorDescription: String? {
        switch self {
        case .readError:
            return NSLocalizedString("Could not load MyImages data, please reinstall the app.", comment: "")
        case .decodingError, .readImageError:
            return NSLocalizedString("There was a problem with loading your images. Please create a new image to start over.", comment: "")
        case .saveImageError:
            return NSLocalizedString("Could not save the images. Please reinstall the app.", comment: "")
        default:
            return NSLocalizedString("Could not save the MyImage data. Please reinstall the app", comment: "")
        }
    }
    
    struct ErrorType: Identifiable {
        let id = UUID()
        let error: MyImageError
        var message: String {
            return error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}
