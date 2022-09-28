//
//  Plant.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation
import Datez
import UIKit

struct Plant: Identifiable, Hashable {
    var id: UUID
    var name: String
    var picture: UIImage
    var waterInterval: WaterInterval
    var lastWaterDate: Date
    
    var timeToWater: DateInterval {
        let lastWateringUntilNow = DateInterval(start: lastWaterDate, end: Date())
        let _remainingTimeToWater = ceil(waterInterval.asTimeInterval - lastWateringUntilNow.duration)
        return DateInterval(start: Date(), duration: _remainingTimeToWater)
    }
    
    mutating func water() -> Void {
        self.lastWaterDate = Date()
    }
    
    init(name: String, picture: UIImage? = nil, waterInterval: WaterInterval, lastWaterDate: Date? = nil) {
        self.id = UUID()
        self.name = name
        self.picture = picture ?? UIImage(systemName: "photo")!
        self.waterInterval = waterInterval
        self.lastWaterDate = lastWaterDate ?? Date()
    }
}

// MARK: sample data
extension Plant {
    static let sampleData = [
        Plant(name: "Ziemiokulas", picture: UIImage(named: "plant-zz"), waterInterval: .everyTwoWeeks, lastWaterDate: Date() - 1.weeksOfYear.timeInterval),
        Plant(name: "Aloes", picture: UIImage(named: "plant-aloe"), waterInterval: .quarterly),
        Plant(name: "Dracena", picture: UIImage(named: "plant-dracena"), waterInterval: .everyEightDays, lastWaterDate: Date() - 3.days.timeInterval)
    ]
}

// MARK: constructor for tests
extension Plant {
    init(waterInterval: WaterInterval, lastWaterDate: Date? = nil) {
        self.id = UUID()
        self.name = "IR"
        self.picture = UIImage(systemName: "photo")!
        self.waterInterval = waterInterval
        self.lastWaterDate = lastWaterDate ?? Date()
    }
}
