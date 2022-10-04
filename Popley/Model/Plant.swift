//
//  Plant.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation
import Datez
import UIKit

struct Plant: Identifiable, Codable {
    var id: UUID
    var name: String
    var imageWrapper: UIImageWrapper
    var waterInterval: WaterInterval
    var lastWaterDate: Date
    
    init(name: String, picture: UIImage? = nil, waterInterval: WaterInterval, lastWaterDate: Date? = nil) {
        let id = UUID()
        self.id = id
        self.name = name
        self.imageWrapper = UIImageWrapper(id: id)
        self.waterInterval = waterInterval
        self.lastWaterDate = lastWaterDate ?? Date()
    }
}

// MARK: Hashable
extension Plant: Hashable {
    static func == (lhs: Plant, rhs: Plant) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: methods and computed properties
extension Plant {
    var timeToWater: DateInterval  {
        var _timeToWater: DateInterval?
        let lastWateringUntilNow = DateInterval(start: lastWaterDate, end: Date())
        let _remainingTimeToWater = ceil(waterInterval.asTimeInterval - lastWateringUntilNow.duration)
        if _remainingTimeToWater > 0 {
            _timeToWater = DateInterval(start: Date(), duration: _remainingTimeToWater)
        } else {
            _timeToWater = DateInterval()
        }
        return _timeToWater!
    }
    
    mutating func water() -> Void {
        self.lastWaterDate = Date()
    }
}

// MARK: sample data
extension Plant {
    static let sampleData = [
        Plant(name: "Ziemiokulas", picture: UIImage(named: "plant-zz"), waterInterval: .everyTwoWeeks, lastWaterDate: Date() - 1.weeksOfYear.timeInterval),
        Plant(name: "Aloes", picture: UIImage(named: "plant-aloe"), waterInterval: .quarterly),
        Plant(name: "Dracena", picture: UIImage(named: "plant-dracena"), waterInterval: .everyEightDays, lastWaterDate: Date() - 3.days.timeInterval)
    ]
    static let thirstyPlants = [
        Plant(name: "Ziemiokulas", picture: UIImage(named: "plant-zz"), waterInterval: .everyTwoWeeks, lastWaterDate: Date() - 2.weeksOfYear.timeInterval),
        Plant(name: "Aloes", picture: UIImage(named: "plant-aloe"), waterInterval: .quarterly, lastWaterDate: Date() - 5.weekOfYear.timeInterval),
        Plant(name: "Dracena", picture: UIImage(named: "plant-dracena"), waterInterval: .everyEightDays, lastWaterDate: Date() - 9.days.timeInterval)
    ]
}

// MARK: constructor for tests
extension Plant {
    init(waterInterval: WaterInterval, lastWaterDate: Date? = nil) {
        let id = UUID()
        self.id = id
        self.name = "IR"
        self.imageWrapper = UIImageWrapper(id: id)
        self.waterInterval = waterInterval
        self.lastWaterDate = lastWaterDate ?? Date()
    }
}
