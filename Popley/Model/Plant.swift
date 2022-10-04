//
//  Plant.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation
import Datez
import UIKit

struct Plant: Identifiable {
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

extension Plant: Hashable {
    static func == (lhs: Plant, rhs: Plant) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: methods and computed properties
extension Plant {
    // FIXME: negative dates
    var timeToWater: DateInterval {
        let lastWateringUntilNow = DateInterval(start: lastWaterDate, end: Date())
        let _remainingTimeToWater = ceil(waterInterval.asTimeInterval - lastWateringUntilNow.duration)
        return DateInterval(start: Date(), duration: _remainingTimeToWater)
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
