//
//  PlantTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 14/09/2022.
//

import XCTest
@testable import Popley

final class PlantTests: XCTestCase {
    var plant: Plant?
    
    override func setUp() async throws {
        try await super.setUp()
        // for stateless operations; the class is marked final,
        // therfore stuff is not overridable
        plant = Plant(name: "IR", picture: "IR", waterInterval: WaterInterval(frequency: 1, interval: .day))
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertTrue(true)
    }
    
    func testNewPlantIsAssumedToBeWateredNow() {
        // dunno lol
        XCTAssertEqual(self.plant!.lastWaterDate.timeIntervalSince1970, Date().timeIntervalSince1970, accuracy: 0.1)
    }
    
    func testPlantWateringResetsTimer() {
        var plant = Plant(name: "IR", picture: "IR", waterInterval: WaterInterval(frequency: 1, interval: .day))
        let timeToWaterBeforeWatering = plant.timeToWater
        
        plant.water()
        
        XCTAssertNotEqual(plant.timeToWater, timeToWaterBeforeWatering)
        XCTAssertGreaterThan(plant.timeToWater, timeToWaterBeforeWatering)
    }

}
