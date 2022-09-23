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
    
    func addPlant(named name: String, withPicture picture: UIImage, wateredEvery days: Int, lastWatered date: Date) {
        let interval = WaterInterval(days: days)!
        let plant = Plant(name: name, picture: picture, waterInterval: interval, lastWaterDate: date)
        plants.append(plant)
    }
    
    func navigateToNextPage(_ page: Page) {
        path.append(page)
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
