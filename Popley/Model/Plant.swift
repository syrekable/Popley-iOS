//
//  Plant.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation
import Datez

struct Plant: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    // TODO: change to actual image
    var picture: String
    var waterInterval: WaterInterval
    var lastWaterDate = Date()
    
    var timeToWater: DateInterval {
        DateInterval(start: lastWaterDate, duration: waterInterval.asTimeInterval)
    }
    
    mutating func water() -> Void {
        self.lastWaterDate = Date()
    }
}

extension Plant {
    static let sampleData = [
        Plant(name: "Ziemiokulas", picture: "plant-zz", waterInterval: .everyTwoWeeks),
        Plant(name: "Aloes", picture: "plant-aloe", waterInterval: .quarterly),
        Plant(name: "Dracena", picture: "plant-dracena", waterInterval: .everyEightDays)
    ]
}
