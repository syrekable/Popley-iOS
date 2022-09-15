//
//  PlantTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 14/09/2022.
//

import XCTest
import Datez
@testable import Popley

final class PlantTests: XCTestCase {
    
    func testNewPlantIsAssumedToBeWateredNow() {
        let plant = Plant(name: "IR", picture: "IR", waterInterval: DescriptiveDateInterval(frequency: 1, interval: .day))
        XCTAssertEqual(plant.lastWaterDate.timeIntervalSince1970,
                       Date().timeIntervalSince1970,
                       accuracy: 0.1)
    }
    
    func testPlantWateringResetsTimer() {
        var plant = Plant(name: "IR", picture: "IR", waterInterval: DescriptiveDateInterval(frequency: 1, interval: .day))
        let timeToWaterBeforeWatering = plant.timeToWater
        
        plant.water()
        
        XCTAssertNotEqual(plant.timeToWater, timeToWaterBeforeWatering)
        XCTAssertGreaterThan(plant.timeToWater, timeToWaterBeforeWatering)
    }
    
    func testPlantWateringDateIsResetCorrectly() {
        var plants = Plant.sampleData
        
        // can't mutate while iterating
        plants[0].water()
        plants[1].water()
        plants[2].water()
        
        for plant in plants {
            XCTAssertEqual(plant.timeToWater.duration,
                           DateInterval(start: Date(),
                                        duration: plant.waterInterval.asTimeInterval).duration,
                           accuracy: 0.1)
        }
    }

}
