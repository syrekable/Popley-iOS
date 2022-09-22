//
//  Model.swift
//  Popley
//
//  Created by Jordan Niedzielski on 17/09/2022.
//

import Foundation
import SwiftUI

class Model: ObservableObject {
    @Published var plants: [Plant] = []
    
    @Published var path = NavigationPath()
    
    func navigateToPlant(_ plant: Plant) {
        path.append(plant)
    }
    
    // lol
    func navigateToNextStageOfAddingNewPlant() {
        switch path.count {
        case 0:
            path.append(Page.plantPicture)
        case 1:
            path.append(Page.plantName)
        case 2:
            path.append(Page.plantSummary)
        default:
            fatalError("Unexpected navigation error.")
        }
        print(path)
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
