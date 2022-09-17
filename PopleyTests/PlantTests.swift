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
        let plant = Plant(name: "IR",
                          picture: "IR",
                          waterInterval: DescriptiveDateInterval(frequency: 1, interval: .day),
                          lastWaterDate: nil)
        XCTAssertEqual(plant.lastWaterDate.timeIntervalSince1970,
                       Date().timeIntervalSince1970,
                       accuracy: 0.1)
    }
    
    func testPlantWateringResetsTimer() {
        var plant = Plant(name: "IR", picture: "IR", waterInterval: DescriptiveDateInterval(frequency: 1, interval: .day),
                          lastWaterDate: Date() - 1.days.timeInterval)
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
    
    func testTimeToWaterForThreeDays() {
        let interval = DescriptiveDateInterval(frequency: 3, interval: .day)
        /*
         let plant = Plant(name: "IR", picture: <#T##String#>, waterInterval: <#T##DescriptiveDateInterval#>)
         */
        
    }

    func testPlantWillNeedWaterInCertainInterval() {
        let lastWaterDate = Date() - 2.days.timeInterval
        let waterInterval = DescriptiveDateInterval(frequency: 3, interval: .day)
        let plant = Plant(name: "IR",
                          picture: "IR",
                          waterInterval: waterInterval,
                          lastWaterDate: lastWaterDate)
        
        XCTAssertLessThan(plant.lastWaterDate, Date())
        XCTAssertEqual(plant.waterInterval.description, "3 days")
        // ...but
        XCTAssertEqual("1 day", plant
            .timeToWater
            .asDescriptiveDateInterval
            .description)
    }
}
