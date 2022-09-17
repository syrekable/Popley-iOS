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
        let plant = Plant(waterInterval: interval)
        
        XCTAssertEqual("3 days", plant
            .timeToWater
            .asDescriptiveDateInterval
            .description)
    }
    
    func testTimeToWaterForOneWeek() {
        let interval = DescriptiveDateInterval(frequency: 1, interval: .week)
        let plant = Plant(waterInterval: interval)
        let expected = "1 week"
        
        XCTAssertEqual(expected, plant
            .timeToWater
            .asDescriptiveDateInterval
            .description)
    }
    
    func testPlantWasWateredThreeDaysAgo() {
        let lastWaterDate = Date() - 3.days.timeInterval
        let interval = WaterInterval(frequency: 4, interval: .day)
        let plant = Plant(waterInterval: interval, lastWaterDate: lastWaterDate)
        
        XCTAssertLessThan(plant.lastWaterDate, Date())
    }
    
    func testPlantWateredTwoDaysAgoWillNeedWaterInOneDay() {
        let lastWaterDate = Date() - 2.days.timeInterval
        let waterInterval = WaterInterval(frequency: 3, interval: .day)
        let plant = Plant(waterInterval: waterInterval,
                          lastWaterDate: lastWaterDate)
        
        let expectedDescription = "1 day"
        let expectedSecondsInInterval: TimeInterval = 24 * 60 * 60
        
        XCTAssertEqual(expectedSecondsInInterval, plant.timeToWater.duration, accuracy: 0.1)
        XCTAssertEqual(expectedDescription, plant
            .timeToWater
            .asDescriptiveDateInterval
            .description)
    }
    
    func testPlantWateredAWeekAgoAgoWillNeedWaterInOneWeek() {
        let lastWaterDate = Date() - 1.weeksOfYear.timeInterval
        let waterInterval = WaterInterval(frequency: 2, interval: .week)
        let plant = Plant(waterInterval: waterInterval,
                          lastWaterDate: lastWaterDate)
        
        let expectedDescription = "1 week"
        let expectedSecondsInInterval: TimeInterval = 7 * 24 * 60 * 60
        
        XCTAssertEqual(expectedSecondsInInterval, plant.timeToWater.duration, accuracy: 0.1)
        XCTAssertEqual(expectedDescription, plant
            .timeToWater
            .asDescriptiveDateInterval
            .description)
    }
}
