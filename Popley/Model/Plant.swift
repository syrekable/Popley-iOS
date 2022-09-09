//
//  Plant.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation
import UIKit

struct Plant: Identifiable {
    var id: UUID = UUID()
    var name: String
    // TODO: change to actual image
    var picture: String
    var wateringInterval: WateringInterval
}

extension Plant {
    static let sampleData = [
        Plant(name: "Ziemiokulas", picture: "plant-zz", wateringInterval: .everyTwoWeeks),
        Plant(name: "Aloes", picture: "plant-aloe", wateringInterval: .quarterly),
        Plant(name: "Dracena", picture: "plant-dracena", wateringInterval: .everyEightDays)
    ]
}
