//
//  Model.swift
//  Popley
//
//  Created by Jordan Niedzielski on 17/09/2022.
//

import Foundation
import SwiftUI

@MainActor
class Model: ObservableObject {
    @Published var path = NavigationPath()
    @Published var plants: [Plant] = Plant.sampleData
    
    func navigateToPlant(_ plant: Plant) {
        path.append(plant)
    }
    
    func addPlant(named name: String, withPicture picture: UIImage, wateredEvery interval: WaterInterval, lastWatered date: Date) {
        let plant = Plant(name: name, picture: picture, waterInterval: interval, lastWaterDate: date)
        plants.append(plant)
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
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
