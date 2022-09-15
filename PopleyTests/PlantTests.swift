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
        let plant = Plant(name: "IR", picture: "IR", waterInterval: WaterInterval(frequency: 1, interval: .day))
        XCTAssertEqual(plant.lastWaterDate.timeIntervalSince1970,
                       Date().timeIntervalSince1970,
                       accuracy: 0.1)
    }
    
    func testPlantWateringResetsTimer() {
        var plant = Plant(name: "IR", picture: "IR", waterInterval: WaterInterval(frequency: 1, interval: .day))
        let timeToWaterBeforeWatering = plant.timeToWater
        
        plant.water()
        
        XCTAssertNotEqual(plant.timeToWater, timeToWaterBeforeWatering)
        XCTAssertGreaterThan(plant.timeToWater, timeToWaterBeforeWatering)
    }
    
    func testPlantWateringDateIsResetCorrectly() {
        var plants = Plant.sampleData
        
        // can't mutate while iterating
        plants[0].water()
        
        XCTAssertEqual(plants[0].timeToWater,
                       DateInterval(start: Date(),
                                    duration: 2.weekOfMonth.timeInterval))
        
    }

}
